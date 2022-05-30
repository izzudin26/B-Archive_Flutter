import 'package:b_archive/components/MainMenu/userProfile.dart';
import 'package:b_archive/model/payloadUser.dart';
import 'package:b_archive/screen/archive.dart';
import 'package:b_archive/screen/formTransaction.dart';
import 'package:b_archive/screen/login.dart';
import 'package:b_archive/screen/scanner.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:b_archive/components/MainMenu/containerMenu.dart';
import 'package:b_archive/service/auth.dart' as _auth;

class MenuItem {
  String label;
  Color color;
  Icon prefixIcon;
  Widget? classWidget;
  void callback;

  MenuItem(
      {required this.label,
      required this.color,
      required this.prefixIcon,
      this.classWidget,
      this.callback});

  Icon getColoredIcon() => Icon(prefixIcon.icon, color: color);
}

class MainMenu extends StatefulWidget {
  String fullname;
  MainMenu({Key? key, required this.fullname}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<MenuItem> menuItems = [
    MenuItem(
        label: "Buat Arsip Transaksi",
        color: Colors.blue,
        prefixIcon: Icon(Icons.create),
        classWidget: FormTransaction()),
    MenuItem(
        label: "Buka Arsip Transaksi",
        color: Colors.blue,
        prefixIcon: Icon(Icons.archive),
        classWidget: Archive()),
    MenuItem(
        label: "Scan Arsip Teman",
        color: Colors.blue,
        prefixIcon: Icon(Icons.qr_code),
        classWidget: Scanner()),
  ];

  Widget menuSection() => Column(
        children: menuItems.map((e) => ContainerMenu(menuItem: e)).toList(),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfile(username: widget().fullname),
            SizedBox(height: size.height * 0.2),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Akses menu kamu yuk !",
                      style: style.textMenuStyle(context, Colors.black)),
                  menuSection(),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: TextButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.resolveWith((states) =>
                              BorderSide(color: Colors.red, width: 1)),
                          shape: MaterialStateProperty.resolveWith((states) =>
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => states.contains(MaterialState.pressed)
                                  ? Colors.red.withOpacity(0.2)
                                  : Colors.white)),
                      onPressed: () async {
                        await _auth.removeToken();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Row(children: [
                          Icon(Icons.logout, color: Colors.red),
                          SizedBox(width: 10),
                          Text("Logout",
                              style: style.textMenuStyle(context, Colors.red))
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

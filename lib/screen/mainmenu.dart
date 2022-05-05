import 'package:b_archive/components/MainMenu/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:b_archive/components/MainMenu/containerMenu.dart';

class MenuItem {
  String label;
  Color color;
  Icon prefixIcon;
  MenuItem({required this.label, required this.color, required this.prefixIcon});
  
  Icon getColoredIcon() => Icon(prefixIcon.icon, color: color);
}

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  List<MenuItem> menuItems = [
    MenuItem(label: "Buat Arsip Transaksi", color: Colors.blue, prefixIcon: Icon(Icons.create)),
    MenuItem(label: "Buka Arsip Transaksi", color: Colors.blue, prefixIcon: Icon(Icons.archive)),
    MenuItem(label: "Scan Arsip Teman", color: Colors.blue, prefixIcon: Icon(Icons.qr_code)),
    MenuItem(label: "Logout Akun", color: Colors.red, prefixIcon: Icon(Icons.logout))
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
            UserProfile(username: "Izzudin Ar Rafiq"),
            SizedBox(height: size.height * 0.2),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Akses menu kamu yuk !", style: style.textMenuStyle(context, Colors.black)),
                  menuSection()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
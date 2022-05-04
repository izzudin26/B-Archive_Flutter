import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;

import 'login.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  String? gender = "male";
  bool isUserAgree = false;

  bool isLoading = false;

  void processLogin() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Registrasi",
              style: style.header(context),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextField(
                controller: fullname,
                decoration: style.textInput(context, "Nama Lengkap"),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: DropdownButtonFormField<String>(
                  decoration: style.textInput(context, "Jenis Kelamin"),
                  value: gender,
                  onChanged: (String? newVal) {
                    setState(() {
                      gender = newVal;
                    });
                  },
                  items: <String>["male", "female"]
                      .map((e) => DropdownMenuItem(
                            child:
                                Text(e == "male" ? "Laki-laki" : "Perempuan"),
                            value: e,
                          ))
                      .toList(),
                )),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextField(
                controller: email,
                decoration: style.textInput(context, "E-Mail"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextField(
                controller: password,
                decoration: style.textInput(context, "Password"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
              child: TextField(
                controller: passwordConfirmation,
                decoration: style.textInput(context, "Konfirmasi Password"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah memiliki akun?",
                  style: style.subtitle(),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Login",
                      style: style.subtitle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      isUserAgree = !isUserAgree;
                    });
                  },
                  child: style.checkBox(context, isUserAgree)
                ),
                Text(
                  "Saya telah menyetujui persyaratan aplikasi",
                  style: style.subtitle(),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: double.infinity,
                    child: Container(
                        decoration: BoxDecoration(),
                        child: TextButton(
                            onPressed: isUserAgree ? processLogin : null,
                            style: style.registrationButton(context, isLoading, !isUserAgree),
                            child: Text(
                              "Registrasi",
                              style: TextStyle(color: Colors.white),
                            )))))
          ],
        ),
      ),
    ));
  }
}

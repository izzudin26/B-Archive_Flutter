import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              "Login",
              style: style.header(context),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextField(
                controller: email,
                decoration: style.textInput(context, "E-Mail"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
              child: TextField(
                controller: password,
                decoration: style.textInput(context, "Password"),
              ),
            ),
            Row(
              children: [
                Text(
                  "Belum memiliki akun?",
                  style: style.subtitle(),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Registrasi",
                      style: style.subtitle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  child: Container(decoration: BoxDecoration(), child: TextButton(onPressed: (){}, style: style.button(context), child: Text("Login", style: TextStyle(color: Colors.white),))))
            )
          ],
        ),
      ),
    ));
  }
}

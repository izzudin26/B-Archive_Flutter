import 'package:b_archive/model/payloadUser.dart';
import 'package:b_archive/screen/mainmenu.dart';
import 'package:b_archive/screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:b_archive/service/auth.dart' as _auth;
import 'package:b_archive/components/snackbarMessage.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  void processLogin() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        PayloadUser user =
            await _auth.login(email.text.trim(), password.text.trim());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainMenu(
                      fullname: user.fullname,
                    )));
      } catch (e) {
        showSnackbar(context, "$e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 4) {
      return "Password minimal memiliki 4 karakter";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailValid.hasMatch(value)) {
      return "Email tidak valid";
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: _formkey,
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
                child: TextFormField(
                  controller: email,
                  validator: (value) => validateEmail(value),
                  decoration: style.textInput(context, "E-Mail"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 15),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) => validatePassword(value),
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
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registration()));
                    },
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
                      child: Container(
                          decoration: BoxDecoration(),
                          child: TextButton(
                              onPressed: processLogin,
                              style: style.button(context, isLoading),
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              )))))
            ],
          ),
        ),
      ),
    ));
  }
}

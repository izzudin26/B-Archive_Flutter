import 'package:b_archive/components/snackbarMessage.dart';
import 'package:b_archive/model/user.dart';
import 'package:b_archive/screen/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:b_archive/service/auth.dart' as _auth;
import 'login.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  String? gender = "male";
  bool isUserAgree = false;

  bool isLoading = false;

  void processLogin() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await _auth.registration(User(
            email: email.text.trim(),
            fullname: fullname.text.trim(),
            gender: gender!,
            password: passwordConfirmation.text.trim()));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainMenu()));
      } catch (e) {
        showSnackbar(context, "$e");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    fullname.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama Tidak boleh kosong";
    }
    if (value.length < 3) {
      return "Nama Harus memiliki 3 karakter lebih";
    }
    return null;
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

  String? validateConfirmationPassword(String? value) {
    if (value == null) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 4) {
      return "Password minimal memiliki 4 karakter";
    }
    if (value != password.text) {
      return "Password tidak sama";
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

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return "Jenis Kelamin tidak boleh kosong";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Form(
          key: _formkey,
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
                child: TextFormField(
                  validator: validateName,
                  controller: fullname,
                  decoration: style.textInput(context, "Nama Lengkap"),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  child: DropdownButtonFormField<String>(
                    validator: validateGender,
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
                child: TextFormField(
                  validator: validateEmail,
                  controller: email,
                  decoration: style.textInput(context, "E-Mail"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: TextFormField(
                  validator: validatePassword,
                  controller: password,
                  decoration: style.textInput(context, "Password"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 15),
                child: TextFormField(
                  validator: validateConfirmationPassword,
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
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
                      onTap: () {
                        setState(() {
                          isUserAgree = !isUserAgree;
                        });
                      },
                      child: style.checkBox(context, isUserAgree)),
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
                              style: style.registrationButton(
                                  context, isLoading, !isUserAgree),
                              child: Text(
                                "Registrasi",
                                style: TextStyle(color: Colors.white),
                              )))))
            ],
          ),
        ),
      ),
    ));
  }
}

import 'dart:async';
import 'package:b_archive/model/payloadUser.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lottie/lottie.dart';
import 'package:b_archive/service/auth.dart' as _auth;
import 'mainmenu.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      await fetchToken();
    });
  }

  Future<void> fetchToken() async {
    String? token = await _auth.getToken();
    if (token != null) {
      PayloadUser user = await _auth.getPayload();
      if (Jwt.isExpired(token)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainMenu(
                      fullname: user.fullname,
                    )));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Lottie.asset('assets/splashloading.json'))),
    );
  }
}

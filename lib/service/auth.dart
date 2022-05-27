import 'dart:convert';
import 'package:b_archive/model/user.dart';
import 'package:http/http.dart' as http;
import 'uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  Map<String, dynamic> payload = Jwt.parseJwt(token);
  print(payload);
  await prefs.setString('fullname', payload['fullname']);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<String?> getFullname() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('fullname');
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('fullname');
}

Future<void> registration(User user) async {
  Uri url = Uri.parse("$serverUri/user/registration");
  final response = await http.post(url,
      body: jsonEncode(user.toJson()),
      headers: {'content-type': 'application/json'});
  Map<String, dynamic> body = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw body["message"];
  }
  if (response.statusCode == 200) {
    saveToken(body["data"]["token"]);
  }
}

Future<void> login(String email, String password) async {
  Map<String, dynamic> body = {"email": email, "password": password};

  Uri url = Uri.parse("$serverUri/user/login");
  final response = await http.post(url,
      body: jsonEncode(body), headers: {'content-type': 'application/json'});
  Map<String, dynamic> resBody = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw resBody["message"];
  }
  if (response.statusCode == 200) {
    saveToken(resBody["data"]["token"]);
  }
}

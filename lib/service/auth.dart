import 'dart:convert';
import 'package:b_archive/model/user.dart';
import 'package:http/http.dart' as http;
import 'uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.getString('token');
}

Future<void> registration(User user) async {
  Uri url = Uri.parse("$serverUri/user/registration");
  final response = await http.post(url, body: user.toJson());
  Map<String, dynamic> body = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception(body["message"]);
  }
  if (response.statusCode == 200) {
    saveToken(body["data"]["token"]);
  }
}

Future<void> login(String email, String password) async {
  Map<String, dynamic> body = {"email": email, "password": password};

  Uri url = Uri.parse("$serverUri/user/login");
  final response = await http.post(url, body: body);
  Map<String, dynamic> resBody = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception(resBody["message"]);
  }
  if (response.statusCode == 200) {
    saveToken(resBody["data"]["token"]);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:b_archive/model/blockdata.dart';
import 'package:http/http.dart' as http;
import 'uri.dart';
import 'package:http_parser/http_parser.dart' as parser;
import 'auth.dart' as _auth;

Future<String> uploadImage({required File image}) async {
  Uri url = Uri.parse("$serverUri/blockchain/image");
  var request = http.MultipartRequest("POST", url);
  request.files.add(new http.MultipartFile.fromBytes(
      "image", image.readAsBytesSync(),
      filename: "${image.path.split("/").last}",
      contentType: parser.MediaType("image", "${image.path.split(".").last}")));
  final res = await request.send();
  final resBytes = await res.stream.toBytes();
  Map<String, dynamic> resbody = jsonDecode(String.fromCharCodes(resBytes));
  if (res.statusCode != 200) {
    throw resbody['message'];
  }
  return resbody['data']['imageName'];
}

Future<void> insertBlockdata({required Metadata metadata}) async {
  Uri url = Uri.parse("$serverUri/blockchain");
  String token = (await _auth.getToken())!;
  print(token);
  final res = await http.post(url,
      body: jsonEncode(metadata.toJson()),
      headers: {"authorization": token, "content-type": "application/json"});
  Map<String, dynamic> body = jsonDecode(res.body);
  if (res.statusCode != 200) {
    throw body['message'];
  }
}

Future<List<Blockdata>> getBlockdata() async {
  String token = (await _auth.getToken())!;
  Uri url = Uri.parse("$serverUri/blockchain");
  final res = await http.get(url, headers: {"Authorization": token});
  Map<String, dynamic> body = jsonDecode(res.body);
  if (res.statusCode != 200) {
    throw body['message'];
  }
  List<Blockdata> data =
      (body['data'] as List).map((e) => Blockdata.fromJson(e)).toList();
  return data;
}

Future<String> generateQRTOKEN({required String hashblock}) async {
  Uri url = Uri.parse("$serverUri/blockchain/block/generate/$hashblock");
  String token = (await _auth.getToken())!;
  final res = await http.get(url, headers: {"Authorization": token});
  Map<String, dynamic> body = jsonDecode(res.body);
  if (res.statusCode != 200) {
    throw body["message"];
  } else {
    return "$serverUri/blockchain/qr/$hashblock";
  }
}

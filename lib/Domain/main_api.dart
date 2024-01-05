import 'dart:convert';

import 'package:bloc_app/Domain/store.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<List<Store>> getall() async {
  List<dynamic> data = [];
  Response response =
      await http.get(Uri.parse("https://fakestoreapi.com/products"));
  if (response.statusCode >= 200 && response.statusCode < 300) {
    final datas = await jsonDecode(response.body);
    data = datas;
  }
  return data.map((json) => Store.fromJson(json)).toList();
}

Future<dynamic> checkloginstatus(String? user, String? pass) async {
  Response res = await http.post(
      Uri.parse(
        "https://fakestoreapi.com/auth/login",
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "username": user.toString(),
        "password": pass.toString(),
        "id": "3"
      }));
  return res;
}

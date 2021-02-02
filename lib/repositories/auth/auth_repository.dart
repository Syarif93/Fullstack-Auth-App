import 'dart:convert';

import 'package:ci4_flutter/models/auth/auth_model.dart';
import 'package:ci4_flutter/repositories/repository.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository with Repository {
  Future hasToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return _prefs.getString("jwt_token") ?? null;
  }

  Future<UserDataModel> getUserData({token}) async {
    try {
      final parts = token.split(".");
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      final String getJti = jsonDecode(decoded)['jti'];

      final response = await http.get(
        "$baseUrl/user/$getJti",
        headers: {
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
        },
      );

      final body = await json.decode(response.body);

      // print(body);

      return UserDataModel.fromJson(body['data']);
    } catch (err) {
      return err;
    }
  }

  Future<UserLoginModel> userLogin(
    String _email,
    String _password,
  ) async {
    try {
      var postBody = json.encode({
        "email": _email,
        "password": _password,
      });

      final response = await http.post("$baseUrl/auth/login", body: postBody);

      final body = json.decode(response.body);
      // print(body);

      return UserLoginModel.fromJson(body);
    } catch (err) {
      return err;
    }
  }

  Future setToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString("jwt_token", token);
  }

  Future removeToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.remove("jwt_token");
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_admin_app/Core/Constants/app_links.dart';
import 'dart:convert';
import 'package:market_admin_app/Model/Enums/request_enum.dart';

class UserService {
  dynamic login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(AppLinks.loginLink), body: {
        email: email,
        password: password,
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        return jsonDecode(response.body)['message'];
      }
      return RequestEnum.serverError;
    } catch (e) {
      debugPrint('** $e');
      return RequestEnum.serverError;
    }
  }
}

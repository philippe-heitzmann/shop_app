import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime(2022, 8, 7, 17, 30);
  String _userid = '';

  // Auth({required token, required expiryDate, required userid}) : _token = token, _expiryDate = expiryDate, _userid = userid;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyB9vCEamaveEfcCCSkyAwIG1B68qcAN1D0');
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(json.decode(response.body));
  }
}

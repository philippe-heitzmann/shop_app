import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime(2022, 8, 7, 17, 30);
  String _userid = '';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyB9vCEamaveEfcCCSkyAwIG1B68qcAN1D0');
    // 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB9vCEamaveEfcCCSkyAwIG1B68qcAN1D0');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }
}

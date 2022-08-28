import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime(2022, 8, 7, 17, 30);
  String _userId = '';

  bool get isAuth {
    return token != '';
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return '';
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    String API_KEY = dotenv.env['API_KEY']!;
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=$API_KEY');
    try {
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
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }
}

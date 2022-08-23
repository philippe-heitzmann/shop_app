import 'package:http/http.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception {
  final String message;
  HttpException({required this.message});

  @override
  String toString() {
    return message;
  }
}

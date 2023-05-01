import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/postContent.dart';

import 'home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  static const String _title = 'chat';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Home(),
    );
  }
}
Color backgroundColor1 = Color.fromARGB(255, 52, 51, 51);
Color backgroundColor2 = Color.fromRGBO(96, 165, 244, 0.89);



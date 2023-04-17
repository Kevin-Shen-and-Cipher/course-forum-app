import 'dart:ui';
import 'package:flutter/material.dart';

import 'main.dart';

class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登入帳號'),
        backgroundColor: backgroundColor1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: InputDecoration(hintText: '學號'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(hintText: '密碼'),
            ),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add login logic
                print('Email: $email');
                print('Password: $password');
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: backgroundColor1 // 背景色
              ),
            ),
          ],
        ),
      ),
    );
  }
}

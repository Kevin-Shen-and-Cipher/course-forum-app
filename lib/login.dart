import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';


class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String username = '';
  String password = '';
  
  Future<void> saveUserData(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    Userdata userData = Userdata.fromJson(jsonMap);
    await prefs.setString('identify', userData.identify);
    await prefs.setString('token', userData.token);
    await prefs.setString('department', userData.department);
  }

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
                  username = value;
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
              onPressed: () async {
                User user = new User(username: username, password: password);

                var response = await http.post(
                  Uri.parse(dotenv.env['Login_API'] as String),
                  body: json.encode(user.toJson()),
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                );

                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("登入成功"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await saveUserData(response.body);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text("確定"),
                        ),
                      ],
                    ),
                  );
                  print('POST request success!');
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("登入失敗，帳號密碼錯誤"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("確定"),
                        ),
                      ],
                    ),
                  );
                  print(
                      'POST request failed with status: ${response.statusCode}');
                }
                print("我是response.body=${response.body}");
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(primary: backgroundColor1),
            ),
          ],
        ),
      ),
    );
  }
}

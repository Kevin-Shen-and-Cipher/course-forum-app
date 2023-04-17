import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/postContent.dart';

import 'addPost.dart';
import 'login.dart';
import 'data.dart';

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
// -----------------------------------------------------

Color backgroundColor1 = Color.fromARGB(255, 52, 51, 51);
Color whiteColor = Colors.white;
bool _Login = true;

Future<List<Post>> getData1(String url) async {
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonObjectList = jsonDecode(utf8.decode(response.bodyBytes));
    List<Post> items = jsonObjectList.map((i) => Post.fromJson(i)).toList();
    return items;
  } else
    throw Exception('Failed to load data!');
}

List<String> items = ["作業系統", "演算法", "軟體工程", "離散數學", "線性代數", "計算機概論", "資料結構"];
String _searchText = "";

List<String> filteredItems() {
  if (_searchText.isEmpty) {
    return items;
  } else {
    return items
        .where((item) => item.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String url1 ='http://course-fourm.ian-shen.live/api/v1/posts';
  Future<List<Post>> response = getData1(url1);
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor1,
        body: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    //收尋欄

                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _searchText = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey, // 設定邊框顏色
                          width: 2.0, // 設定邊框寬度
                        ),
                        borderRadius: BorderRadius.circular(10.0), // 設定邊框圓角
                      ),
                      hintText: 'Search...🔍',
                      hintStyle: TextStyle(color: whiteColor),
                      focusedBorder: OutlineInputBorder(
                        // 點選時 關注
                        borderSide: BorderSide(
                          color: Colors.blue, // 設定邊框顏色
                          width: 2.0, // 設定邊框寬度
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        // 設定邊框圓角
                      ),
                    ),
                  ),
                ),
                IconButton(
                  //新增貼文
                  tooltip: '新增貼文',
                  icon: Icon(Icons.add),
                  color: Color.fromARGB(218, 248, 248, 248),
                  onPressed: () {
                    if (_Login != true) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('警告'),
                            content: Text('請先登入，才能新增貼文哦!!!'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('確定'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => addPost()),
                      );
                    }
                  },
                ),
                IconButton(
                    //登入帳號
                    tooltip: '登入帳號',
                    icon: Icon(Icons.person),
                    iconSize: 30,
                    color: Color.fromARGB(255, 243, 242, 242),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    }),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                  future: response,
                  builder: (context, abc) {
                    print(response);
                    if (abc.hasData) {
                      List<Post> postList1 = abc.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: postList1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 120.0,
                            child: Card(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => postConent(
                                                postList1: postList1,
                                                index: index)),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:6.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${postList1[index].createdBy}    ${postList1[index].createdAt}          瀏覽人數${postList1[index].views}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              '${postList1[index].title}',
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ]),
                                    ))),
                          );
                        },
                      );
                    } else if (abc.hasError) {
                      return Text('${abc.error}');
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ]),
        ));
  }
}

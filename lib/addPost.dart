import 'dart:ui';

import 'package:flutter/material.dart';

import 'main.dart';

class addPost extends StatefulWidget {
  const addPost({super.key});
  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  String title = '';
  String article = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor1,
        body: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  //返回鍵
                  icon: Icon(Icons.arrow_back),
                  color: whiteColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  //置中文字
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '新增貼文&文章',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width, //螢幕寬度
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              maxLines: null, // 可以输入任意多行文本
                              keyboardType: TextInputType.multiline, // 显示多行输入键盘
                              decoration: InputDecoration(
                                labelText: '標題',
                                labelStyle: TextStyle(
                                    fontSize: 20, color: backgroundColor1),
                                hintText: '請輸入標題',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: backgroundColor1, // 設定邊框顏色
                                    width: 10.0, // 設定邊框寬度
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // 點選時 關注
                                  borderSide: BorderSide(
                                    color: backgroundColor1, // 設定邊框顏色
                                    width: 2.0, // 設定邊框寬度
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (text) {
                                title = text;
                                print('輸入的標題為: $title');
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              maxLines: null, // 可以输入任意多行文本
                              keyboardType: TextInputType.multiline, // 显示多行输入键盘
                              decoration: InputDecoration(
                                labelText: '內文敘述',
                                labelStyle: TextStyle(
                                    fontSize: 20, color: backgroundColor1),
                                hintText: '請輸入內文敘述',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: backgroundColor1, // 設定邊框顏色
                                    width: 10.0, // 設定邊框寬度
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // 點選時 關注
                                  borderSide: BorderSide(
                                    color: backgroundColor1, // 設定邊框顏色
                                    width: 2.0, // 設定邊框寬度
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (text) {
                                article = text;
                                print('輸入的內文敘述為: $article');
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Add login logic
                                print('tile: $title');
                                print('article: $article');
                              },
                              child: Text('Post', style: TextStyle(
                                                fontSize: 16.0,
                                              ),),
                              style:ElevatedButton.styleFrom(
                                  primary: backgroundColor1 // 背景色
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ]),
        ));
  }
}

import 'package:flutter_application_1/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data.dart';
import 'login.dart';

Future<List<Tag>> getData(String url) async {
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonObjectList = jsonDecode(utf8.decode(response.bodyBytes));
    List<Tag> items = jsonObjectList.map((i) => Tag.fromJson(i)).toList();
    return items;
  } else
    throw Exception('Failed to load data!');
}

class addPost extends StatefulWidget {
  const addPost({super.key});
  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  String title = '';
  String article = '';
  String tag = '';
  int rating = 4;
  List<int> selectedtagsOptions = [0];
  List<Tag> tags = [];
  final TextEditingController _tagcontroller = TextEditingController();

  Future<List<Tag>> response = getData(dotenv.env['TAG_API'] as String);

  Future<void> refreshData() async {
    setState(() {
      response = getData(dotenv.env['TAG_API'] as String);
    });
  }

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
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  //置中文字
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '新增文章',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height, //螢幕寬度
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(
                          '課程推薦評分',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.star ,size: 35),
                      color: rating >= 1 ? Colors.amber : Colors.grey,
                      onPressed: () {
                        setState(() {
                          rating = 1;
                        });
                      },
                    ),IconButton(
                  icon: Icon(Icons.star,size: 35),
                  color: rating >= 2 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    setState(() {
                      rating = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star,size: 35),
                  color: rating >= 3 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    setState(() {
                      rating = 3;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star,size: 35),
                  color: rating >= 4 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    setState(() {
                      rating = 4;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star,size: 35),
                  color: rating >= 5 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    setState(() {
                      rating = 5;
                    });
                  },
                ),
                  ],
                ),
                
              ],
            ),
                        TextField(
                          maxLines: null, // 可以输入任意多行文本
                          keyboardType: TextInputType.multiline, // 显示多行输入键盘
                          decoration: InputDecoration(
                            filled: true, 
                            fillColor: Colors.blue[50], 
                            labelText: '標題...',
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
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: null, // 可以输入任意多行文本
                          keyboardType: TextInputType.multiline, // 显示多行输入键盘
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue[50],
                            labelText: '內文(請在這裡寫下你最好的文章)',
                            labelStyle: TextStyle(
                                fontSize: 20, color: backgroundColor1),
                            hintText: '內文',
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
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (identity == 'admin') ...[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _tagcontroller,
                                  maxLines: null, // 可以输入任意多行文本
                                  keyboardType:
                                      TextInputType.multiline, // 显示多行输入键盘
                                  decoration: InputDecoration(
                                    labelText: '新增你想要的標籤',
                                    labelStyle: TextStyle(
                                        fontSize: 20, color: backgroundColor1),
                                    hintText: '在這輸入新增的標籤',
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
                                    tag = text;
                                  },
                                ),
                                ElevatedButton(
                                    child: Text(
                                      '點擊新增上述標籤',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: backgroundColor1 // 背景色
                                        ),
                                    onPressed: () async {
                                      //新增標籤後刷新下面listbox選項
                                      bool tagalready = false;
                                      if (tag.isNotEmpty) {
                                        for (int i = 0; i < tags.length; i++) {
                                          if (tag == tags[i].name) {
                                            tagalready = true;
                                          }
                                        }
                                        if (tagalready == true) {
                                          tagalready = false;
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("已經有這個標籤了！"),
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
                                        } else {
                                          CreateTag createTag =
                                              new CreateTag(tag);
                                          var new_tag_response = await http
                                              .post(
                                                  Uri.parse(
                                                      dotenv.env['TAG_API']
                                                          as String),
                                                  body: json.encode(
                                                      createTag.toJson()),
                                                  headers: {
                                                'accept': 'application/json',
                                                'Content-Type':
                                                    'application/json',
                                              });
                                          if (new_tag_response.statusCode ==
                                              201) {
                                            print('POST request success!');
                                            setState(() {
                                              _tagcontroller
                                                  .clear(); // 清空TextField中的內容
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("新增標籤成功，可以在下面選取瞜"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      refreshData();
                                                    },
                                                    child: Text("確定"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            print(
                                                'POST request failed with status: ${new_tag_response.statusCode}');
                                          }
                                          print(new_tag_response.body);
                                        }
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '選擇以下你想要的標籤',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          //CheckboxListTile
                          child: RefreshIndicator(
                            onRefresh: refreshData,
                            child: FutureBuilder<List<Tag>>(
                                future: response,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    tags = snapshot.data!;
                                    return ListView.builder(
                                      itemCount: tags.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: SizedBox(
                                                child: CheckboxListTile(
                                                  title: Text(
                                                    '# ${tags[index].name}',
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  value: selectedtagsOptions
                                                      .contains(tags[index].id),
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      if (value == true) {
                                                        selectedtagsOptions.add(
                                                            tags[index].id);
                                                      } else {
                                                        selectedtagsOptions
                                                            .remove(
                                                                tags[index].id);
                                                      }
                                                    });
                                                  },
                                                  secondary: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      if (identity ==
                                                          'admin') ...[
                                                        ///////////////如果是管理員//////ok
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            var response =
                                                                await http
                                                                    .delete(
                                                              Uri.parse(
                                                                  '${dotenv.env['TAG_API'] as String}/${tags[index].id}'),
                                                              headers: {
                                                                'accept':
                                                                    'application/json',
                                                                'Authorization': 'Bearer $token'//////////////////////////////////////////////
                                                              },
                                                            );
                                                            if (response
                                                                    .statusCode ==
                                                                204) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  title: Text(
                                                                      "刪除標籤成功"),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        refreshData();
                                                                      },
                                                                      child: Text(
                                                                          "確定"),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                              print(
                                                                  'POST request success!');
                                                            } else {
                                                              print(
                                                                  'POST request failed with status: ${response.statusCode}');
                                                            }
                                                            print(
                                                                response.body);
                                                          },
                                                          child: Text(
                                                            '刪除',
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            fixedSize:
                                                                Size(40, 40),
                                                            primary: Colors
                                                                .blueGrey, // 背景颜色
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            final result =
                                                                await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                String text =
                                                                    '';
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      '請輸入要修改的標籤'),
                                                                  content:
                                                                      TextField(
                                                                    onChanged:
                                                                        (value) =>
                                                                            text =
                                                                                value,
                                                                    autofocus:
                                                                        true,
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      child: Text(
                                                                          '取消'),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.of(context).pop(),
                                                                    ),
                                                                    ElevatedButton(
                                                                        child: Text(
                                                                            '確定'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop(text);
                                                                          refreshData();
                                                                        }),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            CreateTag
                                                                createTag =
                                                                new CreateTag(
                                                                    result);
                                                            var response =
                                                                await http
                                                                    .patch(
                                                              Uri.parse(
                                                                  '${dotenv.env['TAG_API']}/${tags[index].id}'),
                                                              body: json.encode(
                                                                  createTag
                                                                      .toJson()),
                                                              headers: {
                                                                'Content-Type':
                                                                    'application/json',
                                                                'accept':
                                                                    'application/json',
                                                                'Authorization': 'Bearer $token'//////////////////////////////////////////////
                                                              },
                                                            );
                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  title: Text(
                                                                      "修改標籤成功"),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          "確定"),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                              print(
                                                                  'POST request success!');
                                                            } else {
                                                              print(
                                                                  'POST request failed with status: ${response.statusCode}');
                                                            }
                                                            print(
                                                                response.body);
                                                          },
                                                          child: Text(
                                                            '修改',
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            fixedSize:
                                                                Size(40, 40),
                                                            primary: Colors
                                                                .blueGrey, // 背景颜色
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return CircularProgressIndicator();
                                }),
                          ),
                        ),
                        ElevatedButton(
                          //post按鈕
                          child: Text(
                            'Post',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: backgroundColor1),
                          onPressed: () async {
                            print(
                                'selectedtagsOptions.length=${selectedtagsOptions.length}');
                            CreatPost newpost = new CreatPost(
                              content: article,
                              create_by:
                                  department,
                              created_at: "0",
                              score: rating,
                              tags: selectedtagsOptions,
                              title: title,
                            );
                            print(newpost.toJson());

                            var response = await http.post(
                              Uri.parse(dotenv.env['POST_API'] as String),
                              body: json.encode(newpost.toJson()),
                              headers: {
                                'accept': 'application/json',
                                'authorization':'Bearer $token', ////////////////////////////////////ok
                                'Content-Type': 'application/json'
                              },
                            );
                            if (response.statusCode == 201) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("成功發出文章，等待管理員審核"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pop(context, true);
                                      },
                                      child: Text("確定"),
                                    ),
                                  ],
                                ),
                              );
                              print('POST request success!');
                            } else {
                              print(
                                  'POST request failed with status: ${response.statusCode}');
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("建立文章失敗"),
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
                            }
                            print(response.body);
                            print(response.headers['authorization']); /////////////////////
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ]),
        ));
  }
}

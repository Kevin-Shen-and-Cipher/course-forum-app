import 'dart:async';
// import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'postContent.dart';
import 'addPost.dart';
import 'login.dart';
import 'data.dart';
import 'main.dart';

Future<List<Post>> getData1(String url) async {
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonObjectList = jsonDecode(utf8.decode(response.bodyBytes));
    List<Post> items = jsonObjectList.map((i) => Post.fromJson(i)).toList();
    return items;
  } else
    throw Exception('Failed to load data!');
}

bool CaseInsensitiveContains(String source, String pattern) {
  final patternLC = pattern.toLowerCase();
  final patternUC = pattern.toUpperCase();
  final sourceLC = source.toLowerCase();
  final sourceUC = source.toUpperCase();
  return sourceLC.contains(patternLC) || sourceUC.contains(patternUC);
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchText = "";
  List<Post> searchResults = [];
  List<Post> postList1 = [];
  TextEditingController _textController = TextEditingController();
  Future<List<Post>> response = getData1(post_url);

  @override
  void initState() {
    super.initState();
    _textController.text = tagText;
  }

  void onSubmitted(String value) {
    setState(() {
      searchText = value.toLowerCase();
      searchResults = [];
      searchResults = postList1
          .where((post) =>
              CaseInsensitiveContains(post.title, searchText) ||
              CaseInsensitiveContains(post.content, searchText) ||
              post.tags
                  .any((tag) => CaseInsensitiveContains(tag.name, searchText)))
          .toList();
    });
  }

  Future<void> refreshData() async {
    setState(() {
      response = getData1(post_url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: backgroundColor1,
          body: SafeArea(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          //收尋欄
                          controller: _textController,
                          onChanged: (value) {
                            onSubmitted(value);
                          },
                          onSubmitted: (value) {
                            onSubmitted(value);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: backgroundColor1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // 設定邊框顏色
                                width: 2, // 設定邊框寬度
                              ),
                              borderRadius:
                                  BorderRadius.circular(10.0), // 設定邊框圓角
                            ),
                            hintText: 'Search...🔍',
                            hintStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              // 點選時 關注
                              borderSide: BorderSide(
                                color: Colors.blue, // 設定邊框顏色
                                width: 2, // 設定邊框寬度
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              // 設定邊框圓角
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      if (token == '') ...[
                        ///////////////////////如果沒有登入////////////////////////////////
                        SizedBox(
                          width: 80,
                        ),
                        IconButton(
                            //登入帳號
                            tooltip: '登入帳號',
                            icon: Icon(Icons.person),
                            iconSize: 35,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()),
                              );
                            }),
                        Text(
                          '未登入', /////////////////////////////////////////////////////////////////////////////////////////
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          width: 80,
                        ),
                        IconButton(
                            //登入帳號
                            tooltip: '登出帳號',
                            icon: Icon(Icons.person),
                            iconSize: 35,
                            color: Colors.white,
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('提示'),
                                    content: Text('是否要登出？'),
                                    actions: [
                                      TextButton(
                                        child: Text('取消'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('確定'),
                                        onPressed: () {
                                          // /////////////////////////登出後要清掉token//////////////////////////////////////////////////////////////
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                        Text(
                          '資訊工程系', //////////////改成apartmemt///////////////////////////////////////////////////////////////////////////
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
              if (searchText.isEmpty && tagText.isEmpty)
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshData,
                    child: FutureBuilder<List<Post>>(
                        future: response,
                        builder: (context, abc) {
                          if (abc.hasData) {
                            postList1 = abc.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: postList1.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 140.0,
                                  child: Card(
                                      child: InkWell(
                                          onTap: () async {
                                            var result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      postConent(
                                                          postList1: postList1,
                                                          index: index)),
                                            );
                                            if (result == true) {
                                              setState(() {
                                                refreshData();
                                              });
                                            }
                                          },
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${postList1[index].create_by}  ${postList1[index].created_at.substring(0, 10)}     瀏覽人數:${postList1[index].views}',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: backgroundColor1,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    '${postList1[index].title}',
                                                    style: const TextStyle(
                                                      fontSize: 23.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    ' ' +
                                                        '${postList1[index].content}' +
                                                        '.....',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: backgroundColor1,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (postList1[index]
                                                          .tags
                                                          .isNotEmpty)
                                                        for (int i = 0;
                                                            i <
                                                                postList1[index]
                                                                    .tags
                                                                    .length;
                                                            i++)
                                                          Text(
                                                            '#${postList1[index].tags[i].name}',
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  backgroundColor1,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                          ),
                                                    ],
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
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshData,
                    child: FutureBuilder<List<Post>>(
                        future: response,
                        builder: (context, abc) {
                          if (abc.hasData) {
                            postList1 = abc.data!;
                            if (tagText.isEmpty) {
                              searchText = searchText.toLowerCase();
                              tagText = '';
                            } else {
                              searchText = tagText.toLowerCase();
                            }
                            // searchText = tagText.toLowerCase();
                            searchResults = [];
                            searchResults = postList1
                                .where((post) =>
                                    CaseInsensitiveContains(
                                        post.title, searchText) ||
                                    CaseInsensitiveContains(
                                        post.content, searchText) ||
                                    post.tags.any((tag) =>
                                        CaseInsensitiveContains(
                                            tag.name, searchText)))
                                .toList();
                            tagText = '';

                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchResults.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 140.0,
                                  child: Card(
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      postConent(
                                                          postList1: postList1,
                                                          index: index)),
                                            );
                                          },
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${searchResults[index].create_by}  ${searchResults[index].created_at.substring(0, 10)}     瀏覽人數:${searchResults[index].views}',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: backgroundColor1,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    '${searchResults[index].title}',
                                                    style: const TextStyle(
                                                      fontSize: 23.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    ' ' +
                                                        '${searchResults[index].content}' +
                                                        '.....',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: backgroundColor1,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (searchResults[index]
                                                          .tags
                                                          .isNotEmpty)
                                                        for (int i = 0;
                                                            i <
                                                                searchResults[
                                                                        index]
                                                                    .tags
                                                                    .length;
                                                            i++)
                                                          Text(
                                                            '#${searchResults[index].tags[i].name}',
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  backgroundColor1,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                          ),
                                                    ],
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
                )
            ]),
          )),
      AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        right:16,
        bottom: 16 ,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 119, 119, 118),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              if (token=='2') {////////////如果有登入/////////////////////////////////////////////////////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addPost()),
                );
              } else {
                 showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('小叮嚀'),
                      content: Text('登入後，才能新增貼文哦!!!'),
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
               
              }
            },
            child: Container(
              width: 65,
              height: 65,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }
}

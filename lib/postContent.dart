import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'home.dart';
import 'data.dart';
import 'login.dart';

String tagText = '';

class postConent extends StatefulWidget {
  final List<Post> postList;
  final int index;
  const postConent({super.key, required this.postList, required this.index});

  @override
  State<postConent> createState() => _postConentState();
}

class _postConentState extends State<postConent> {
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
                      '${widget.postList[widget.index].title}',
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
                  width: MediaQuery.of(context).size.width, //螢幕寬度
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Text('文章評價'),
                            widget.postList[widget.index].score == 1 ||
                                    widget.postList[widget.index].score == 0
                                ? Image.asset('assets/images/star1.png',
                                    width: 280)
                                : widget.postList[widget.index].score == 2
                                    ? Image.asset('assets/images/star2.png',
                                        width: 280)
                                    : widget.postList[widget.index].score == 3
                                        ? Image.asset('assets/images/star3.png',
                                            width: 280)
                                        : widget.postList[widget.index]
                                                    .score ==
                                                4
                                            ? Image.asset(
                                                'assets/images/star4.png',
                                                width: 280)
                                            : Image.asset(
                                                'assets/images/star5.png',
                                                width: 280)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Image.asset(
                            'assets/images/user.png',
                            width: 40,
                          ),
                          Text(
                            '${widget.postList[widget.index].create_by}',
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ]),
                        if (identity == 'admin') ...[
                          //////如果是管理員///////////ok
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  var response = await http.delete(
                                    Uri.parse(
                                        '${dotenv.env['POST_API']as String}/${widget.postList[widget.index].id}'),
                                    headers: {
                                      'accept': 'application/json'
                                      // 'Authorization': 'Bearer $token'//////////////////////////////////////////////
                                    },
                                  );
                                  if (response.statusCode == 204) {                                  
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("刪除文章成功"),
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
                                  }
                                  print(response.body);
                                },
                                child: Text(
                                  '刪除文章',
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  UpdatePost updatePost =
                                      new UpdatePost(state: true);

                                  var response = await http.patch(
                                    Uri.parse(
                                        '${dotenv.env['POST_API']as String}/${widget.postList[widget.index].id}'),
                                    body: json.encode(updatePost.toJson()),
                                    headers: {
                                      'accept': 'application/json',
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer $token'//////////////////////////////////////////////
                                    },
                                  );
                                  if (response.statusCode == 200) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("文章審核成功"),
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
                                  }
                                  print(response.body);
                                },
                                child: Text(
                                  '通過審核',
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                '目前狀態:${widget.postList[widget.index].state}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${widget.postList[widget.index].created_at.substring(0, 10)}    瀏覽人數${widget.postList[widget.index].views}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.postList[widget.index].title}",
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '${widget.postList[widget.index].content}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        if (widget.postList[widget.index].tags.isNotEmpty)
                          for (int i = 0;
                              i < widget.postList[widget.index].tags.length;
                              i++)
                            GestureDetector(
                              onTap: () {
                                tagText =
                                    '${widget.postList[widget.index].tags[i].name}';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '#${widget.postList[widget.index].tags[i].name}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.blue,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ])),
                            )
                      ],
                    ),
                  )),
            ),
          ]),
        ));
  }
}

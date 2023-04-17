import 'dart:ui';
import 'package:flutter/material.dart';

import 'main.dart';
import 'data.dart';

class postConent extends StatefulWidget {
  final List<Post> postList1;
  final int index;
  const postConent({super.key, required this.postList1, required this.index});

  @override
  State<postConent> createState() => _postConentState();
}

class _postConentState extends State<postConent> {
  @override
  Widget build(BuildContext context) {
    print(widget.postList1[widget.index].score);
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
                      '${widget.postList1[widget.index].title}',
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
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [Text('文章評價'),
                            widget.postList1[widget.index].score == 1
                                ? Image.asset('assets/images/star1.png',
                                    width: 280)
                                : widget.postList1[widget.index].score == 2
                                    ? Image.asset('assets/images/star2.png',
                                        width: 280)
                                    : widget.postList1[widget.index].score == 3
                                        ? Image.asset('assets/images/star3.png',
                                            width: 280)
                                        : widget.postList1[widget.index].score ==
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
                        Row(
                          children: [Image.asset('assets/images/user.png',width: 40,),Text('${widget.postList1[widget.index].createdBy}',)]
                          ),
                        Text(
                          '${widget.postList1[widget.index].createdAt}    瀏覽人數${widget.postList1[widget.index].views}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.postList1[widget.index].title}",
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '${widget.postList1[widget.index].content}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ]),
        ));
  }
}

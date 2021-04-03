import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app_tj_v1_3/screens/chat/chat_item.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoomScreen extends StatefulWidget {
  final roomId;
  final userId;
  final roomName;
  final roomImage;

  ChatRoomScreen({this.roomId, this.userId, this.roomName, this.roomImage});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  SharedPreferences sharedPreferences;
  String LoginId;
  TextEditingController mgText = TextEditingController();
  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int count = 1;

  String saveStatusMessage;

  loadPosts() async {
    print('userIds ${LoginId}');
    apigetMessageChat(widget.roomId).then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    //api mgStatus จาก 1 ให้ เป็น 2
    apigetMessageChat(widget.roomId).then((res) async {
      _postsController.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _postsController = new StreamController();
    //api mgStatus จาก 1 ให้ เป็น 2
    _getUserId();
    loadPosts();
    super.initState();
  }

  Future<Null> _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    LoginId = sharedPreferences.getString("LoginId");
    setState(() {});
  }

  messageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.emoji_emotions),
            iconSize: 25,
            color: Colors.black,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: mgText,
              decoration: InputDecoration.collapsed(
                hintText: 'Sand a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.black,
            onPressed: () {
              print("${mgText}");
              apiInsertMessageChat(
                widget.roomId,
                LoginId,
                mgText.text.trim(),
                "1",
              );
              _handleRefresh();
              setState(() {
                mgText.text = "";
              });
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text('${widget.roomName}'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: _postsController.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print('Has error: ${snapshot.hasError}');
                    print('Has data: ${snapshot.hasData}');
                    print('Snapshot Data ${snapshot.data}');
                    if (snapshot.hasError) {
                      return Text(snapshot.error);
                    } else if (snapshot.hasData) {
                      if(snapshot.data[0].message == '1'){
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: Scrollbar(
                                child: RefreshIndicator(
                                  onRefresh: _handleRefresh,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0, top: 10),
                                    child: SingleChildScrollView(
                                      physics:
                                      const AlwaysScrollableScrollPhysics(),
                                      reverse: true,
                                      child: Column(
                                        children: <Widget>[
                                          for (var index = 0;
                                          index < snapshot.data.length;
                                          index++)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10.0),
                                              child: ChatItem(
                                                  message: snapshot.data[index],
                                                  image: widget.roomImage,
                                                  isMe: snapshot
                                                      .data[index].userId ==
                                                      LoginId,
                                                  isContinue: index == 0
                                                      ? false
                                                      : (snapshot.data[index - 1]
                                                      .userId ==
                                                      snapshot.data[index]
                                                          .userId) &&
                                                      (snapshot
                                                          .data[index - 1]
                                                          .mgModifyDate ==
                                                          snapshot.data[index]
                                                              .mgModifyDate)),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }else{
                        snapshot.data[0].message = saveStatusMessage;
                        print('${saveStatusMessage}');
                        return Text('test');
                      }
                    } else if (snapshot.connectionState !=
                        ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Text('No Posts');
                    } else {
                      return Text('เกิดข้อผิดพาด');
                    }
                  },
                ),
              ),
              messageInput(),
            ],
          ),
        ),
      ),
    );
  }
}

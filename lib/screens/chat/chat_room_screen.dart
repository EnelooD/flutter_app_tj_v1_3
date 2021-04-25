import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/screens/chat/chat_item.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoomScreen extends StatefulWidget {
  String roomId;
  String roomName;
  String roomImage;
  String userId;
  String mgText;

  ChatRoomScreen(
      {Key key,
      this.mgText,
      this.roomId,
      this.roomName,
      this.roomImage,
      this.userId})
      : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final mgText = TextEditingController();

  SharedPreferences sharedPreferences;
  String LoginId;
  String LoginName;
  String LoginImage;

  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final String URL = "https://oomhen.000webhostapp.com/thaiandjourney_services";
  int count = 1;

  ProgressDialog progressDialog =
  ProgressDialog.getProgressDialog('Processing...', true);

  loadPosts() async {
    apigetMessageChat(widget.roomId).then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  // showSnack() {
  //   return scaffoldKey.currentState.showSnackBar(
  //     SnackBar(
  //       content: Text('New content loaded'),
  //     ),
  //   );
  // }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    //api mgStatus จาก 1 ให้ เป็น 2
    Duration(seconds: 1);
    apigetMessageChat(widget.roomId).then((res) async {
      _postsController.add(res);
      // showSnack();
      return null;
    });
  }

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
      LoginName = sharedPreferences.getString("LoginName");
      LoginImage = sharedPreferences.getString("LoginImage");
    });
  }

  @override
  void initState() {
    //api mgStatus จาก 1 ให้ เป็น 2
    _startTimer();
    _getUserId();
    loadPosts();
    _postsController = new StreamController();
    mgText.addListener(_printLatestValue);
    super.initState();
  }

  _printLatestValue() {
    print("Second text field: ${mgText.text}");
    if(mgText.text == ''){
      setState(() {
        return mgText.text == '';
      });
    }else{
      setState(() {
        return mgText.text == mgText.text;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    mgText.dispose();
    super.dispose();
  }

  messageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
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
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Sand a message...',
              ),
            ),
          ),
          buttonSend(mgText.text),
          // ButtonSend(
          //   roomId: widget.roomId,
          //   LoginId: LoginId,
          //   mgText: mgText.text,
          // ),
        ],
      ),
    );
  }

  buttonSend(String showButton) {
    if (showButton == "") {
      return Container();
    } else {
      if (widget.roomId == "") {
        print('adb');
        return IconButton(
          icon: Icon(Icons.send),
          iconSize: 25,
          color: Colors.black,
          onPressed: () {
            print('mgText.text ${mgText.text}');
            apiInsertRoom(
              LoginId,
              widget.userId,
              "1",
              LoginName,
              LoginImage,
              widget.roomName,
              widget.roomImage,
            ).then((value) async{
              await apiInsertMessage(
                value[0].roomId,
                LoginId,
                mgText.text,
                "1",
              );
              setState(() {
                mgText.text = "";
              });
              FocusScope.of(context).unfocus();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return ChatRoomScreen(
                      roomId: value[0].roomId,
                      roomName: widget.roomName,
                      roomImage: widget.roomImage,
                    );
                  }),
                ),
              );
            });
          },
        );
      }
      else {
        print('send');
        return IconButton(
          icon: Icon(Icons.send),
          iconSize: 25,
          color: Colors.black,
          onPressed: () {
            apiInsertMessage(
              widget.roomId,
              LoginId,
              mgText.text,
              '1',
            );
            FocusScope.of(context).unfocus();
            setState(() {
              mgText.text = "";
            });
            _handleRefresh();
          },
        );
      }
    }
  }

  int _counter = 2;
  Timer _timer;

  void _startTimer() {
    _counter = 2;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _handleRefresh();
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.roomName}',
          style: Constants.titleStyle,
        ),
        backgroundColor: Colors.brown,
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
                      print('snapshot.data[0].message ${snapshot.data[0].message}');
                      if (snapshot.data[0].message == '1') {
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: Scrollbar(
                                child: RefreshIndicator(
                                  onRefresh:  _handleRefresh,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: ChatItem(
                                                  message: snapshot.data[index],
                                                  image: widget.roomImage,
                                                  isMe: snapshot
                                                          .data[index].userId ==
                                                      LoginId,
                                                  isContinue: index == 0
                                                      ? false
                                                      : (snapshot
                                                                  .data[
                                                                      index - 1]
                                                                  .userId ==
                                                              snapshot
                                                                  .data[index]
                                                                  .userId) &&
                                                          (snapshot
                                                                  .data[
                                                                      index - 1]
                                                                  .mgModifyDate ==
                                                              snapshot
                                                                  .data[index]
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
                      } else {
                        return Container();
                      }

                    } else if (snapshot.connectionState !=
                        ConnectionState.done) {
                      return progressDialog;
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

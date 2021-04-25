import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/screens/drawer.dart';
import 'package:flutter_app_tj_v1_3/screens/chat/chat_room_screen.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';

class InboxUI extends StatefulWidget {
  @override
  _InboxUIState createState() => _InboxUIState();
}

class _InboxUIState extends State<InboxUI> {
  final searchName = TextEditingController();

  SharedPreferences sharedPreferences;
  String LoginId;

  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final String URL = "https://oomhen.000webhostapp.com/thaiandjourney_services";
  int count = 1;

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('Processing...', true);

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
      loadPosts();
    });
  }

  loadPosts() async {
    apigetChatRoom(LoginId).then((res) async {
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
    apigetChatRoom(LoginId).then((res) async {
      _postsController.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _getUserId();
    _postsController = new StreamController();
    searchName.addListener(_printLatestValue);
    super.initState();
  }

  _printLatestValue() {
    print("Second text field: ${searchName.text}");
    if (searchName.text == '') {
      setState(() {
        return searchName.text == '';
      });
    } else {
      setState(() {
        return searchName.text == searchName.text;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: DrawerAom(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'INBOX',
          style: Constants.titleStyle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 90),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.light
                ? Constants.lightBGColors
                : Constants.darkBGColors,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: TextFormField(
                      autofocus: false,
                      controller: searchName,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: IconButton(
                          onPressed: () {
                            apiSearchRoom(
                              LoginId,
                              searchName.text,
                            ).then((value) {
                              FocusScope.of(context).unfocus();
                              if (value[0].message == '2') {
                                return null;
                              } else {
                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ChatRoomScreen(
                                        roomId: value[0].roomId,
                                        roomName: value[0].roomName,
                                        roomImage: value[0].roomImage,
                                      );
                                    },
                                  ),
                                );
                              }
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: Constants.border,
                        disabledBorder: Constants.border,
                        border: Constants.border,
                        errorBorder: Constants.border,
                        focusedErrorBorder: Constants.border,
                        focusedBorder: Constants.border,
                        suffixIcon: IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (searchName.text != '') {
                              return searchName.text = '';
                            }
                          },
                          icon: Icon(
                            searchName.text == ''
                                ? null
                                : Icons.remove_circle_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: _postsController.stream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            print('Has error: ${snapshot.hasError}');
                            print('Has data: ${snapshot.hasData}');
                            print('Snapshot Data ${snapshot.data}');
                            if (snapshot.hasError) {
                              return Text(snapshot.error);
                            } else if (snapshot.hasData) {
                              if(snapshot.data[0].message=="1"){
                                return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: ListView.builder(
                                          padding:
                                          const EdgeInsets.only(bottom: 80),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ChatRoomScreen(
                                                        roomId: snapshot
                                                            .data[index].roomId,
                                                        roomName: snapshot
                                                            .data[index].roomName,
                                                        roomImage: snapshot
                                                            .data[index]
                                                            .roomImage,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          '${URL}${snapshot.data[index].roomImage}'),
                                                      radius: 30.0,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text(
                                                          snapshot.data[index]
                                                              .roomName,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            } else if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return progressDialog;
                            } else if (!snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return Text('No Posts');
                            } else {
                              return Text('เกิดข้อผิดพาด');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/models/data.dart';
import 'package:flutter_app_tj_v1_3/screens/chat/chat_input.dart';
import 'package:flutter_app_tj_v1_3/screens/chat/chat_item.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoomScreen extends StatefulWidget {
  final roomId;
  final userId;
  final roomName;
  final roomImage;

  ChatRoomScreen(
      {this.roomId,
        this.userId,
        this.roomName,
        this.roomImage});
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {

  SharedPreferences sharedPreferences;
  String LoginId;
  ProgressDialog progressDialog =
  ProgressDialog.getProgressDialog('Processing...', true);

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getUserId();
    super.initState();
  }
  @override
  final String URL = "https://oomhen.000webhostapp.com/thaiandjourney_services";
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage('${URL}${widget.roomImage}'),
              radius: 20.0,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.roomName,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                // Text(
                //   widget.roomName,
                //   style: TextStyle(
                //       fontSize: 10.0,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.white
                //   ),
                // ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.light
                ? Constants.lightBGColors
                : Constants.darkBGColors,
          ),
        ),
        child: FutureBuilder(
          future: apigetMessageChat(widget.roomId),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              if(snapshot.data[0].message == '2'){
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                        // child: SingleChildScrollView(
                        //   reverse: true,
                        //   child: Column(
                        //     children: <Widget>[
                        //       for (var index = 0; index < snapshot.data.length; index++)
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(vertical: 10.0),
                        //           child: ChatItem(
                        //               message: snapshot.data[index],
                        //               image : widget.roomImage,
                        //               isMe: snapshot.data[index].userId == LoginId,
                        //               isContinue: index == 0
                        //                   ? false
                        //                   : (snapshot.data[index - 1].userId ==
                        //                   snapshot.data[index].userId) &&
                        //                   (snapshot.data[index - 1].mgModifyDate ==
                        //                       snapshot.data[index].mgModifyDate)),
                        //         )
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ChatInput(
                        onPressed: (message) {
                          if (message != null) {
                            setState(() {
                              message.add(
                                widget.roomId,
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ],
                );
              }else{
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            children: <Widget>[
                              for (var index = 0; index < snapshot.data.length; index++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: ChatItem(
                                      message: snapshot.data[index],
                                      image : widget.roomImage,
                                      isMe: snapshot.data[index].userId == LoginId,
                                      isContinue: index == 0
                                          ? false
                                          : (snapshot.data[index - 1].userId ==
                                          snapshot.data[index].userId) &&
                                          (snapshot.data[index - 1].mgModifyDate ==
                                              snapshot.data[index].mgModifyDate)),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ChatInput(
                        onPressed: (message) {
                          if (message != null) {
                            setState(() {
                              message.add(
                                widget.roomId,
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return progressDialog;
            }
          },
        ),
      ),
    );
  }
}

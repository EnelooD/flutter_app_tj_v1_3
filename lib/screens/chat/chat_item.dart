import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/models/data.dart';
import 'package:flutter_app_tj_v1_3/models/message.dart';

import 'package:flutter_app_tj_v1_3/screens/chat/chat_bubble.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatItem extends StatelessWidget {
  final Message message;
  final bool isContinue;
  final String image;
  final bool isMe;
  final String URL = "https://oomhen.000webhostapp.com/thaiandjourney_services";

  const ChatItem({Key key, this.message, this.isContinue, this.image, this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        isMe
            ? Container()
            : isContinue
            ? Container(padding: const EdgeInsets.symmetric(horizontal: 20))
            : CircleAvatar(
          backgroundImage: NetworkImage('${URL}${image}'),
          radius: 20.0,
        ),
        ChatBubble(
          isMe: isMe,
          isContinue: isContinue,
          message: message,
        ),
      ],
    );
  }
}

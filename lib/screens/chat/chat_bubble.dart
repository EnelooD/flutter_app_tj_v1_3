import 'package:flutter/material.dart';

import 'package:flutter_app_tj_v1_3/models/message.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final bool isContinue;
  final Message message;

  ChatBubble(
      {@required this.isMe, @required this.isContinue, @required this.message});

  @override
  Widget build(BuildContext context) {
    // print('message.mgId ${message.mgId}');
    if(!isMe){
      apiUpdateMessage(message.mgId);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        isMe ? _bubbleEndWidget() : Container(),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.brown
                : Colors.brown,
            borderRadius: isMe
                ? isContinue
                ? BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )
                : BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            )
                : isContinue
                ? BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )
                : BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
              minHeight: 30),
          child: Text(
            message.mgText,
            style: TextStyle(
              color: isMe
                  ? Colors.white
                  : Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey,
            ),
          ),
        ),
        isMe ? Container() : _bubbleEndWidget()
      ],
    );
  }

  Widget _bubbleEndWidget() {
    return Column(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          message.mgStatus=='1' ? '' : 'อ่าน',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
        Text(
          message.mgModifyDate,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

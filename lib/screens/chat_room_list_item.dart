import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/models/message_model.dart';

class ChatRoomListItem extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatRoomListItem({this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(chatRoom.sender.imageUrl),
            radius: 30.0,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chatRoom.sender.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  chatRoom.messages.last.text,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                )
              ],
            ),
          ),
          Text(
            chatRoom.messages.last.time,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

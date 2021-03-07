import 'package:flutter_app_tj_v1_3/models/chat_room_model.dart';
import 'package:flutter_app_tj_v1_3/models/user_model.dart';

class ChatRoom {
  final User sender;
  final List<Message> messages;

  ChatRoom({this.sender, this.messages});

}
import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/loginuser/detailregister_ui.dart';
import 'package:flutter_app_tj_v1_3/loginuser/login_ui.dart';
import 'package:flutter_app_tj_v1_3/loginuser/register_ui.dart';
import 'package:flutter_app_tj_v1_3/managelocality/homemanage.dart';
import 'package:flutter_app_tj_v1_3/managelocality/localityregister_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/chat/chat_room_screen.dart';
import 'package:flutter_app_tj_v1_3/screens_ui.dart';
//1:018:00
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginUI(),
      routes: _route,
    ),
  );
}

final _route = <String, WidgetBuilder>{
  '/login_ui': (BuildContext context) => LoginUI(),
  '/register_ui': (BuildContext context) => RegisterUI(),
  '/detailregister_ui': (BuildContext context) => DetailregisterUI(),
  '/screens_home': (BuildContext context) => ScreensUI(),
  '/chatRoom': (BuildContext context) => ChatRoomScreen(),
  '/homemanage': (BuildContext context) => ManagePlaceUI(),
  '/localityregister': (BuildContext context) => LocalityRegisterUI(),
};
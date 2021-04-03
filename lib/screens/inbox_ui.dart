import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/models/chat_room_model.dart';
import 'package:flutter_app_tj_v1_3/screens/chat/chat_room_screen.dart';
import 'package:flutter_app_tj_v1_3/screens/chat_room_list_item.dart';
import 'package:flutter_app_tj_v1_3/screens/drawer.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InboxUI extends StatefulWidget {
  @override
  _InboxUIState createState() => _InboxUIState();
}

class _InboxUIState extends State<InboxUI> {
  SharedPreferences sharedPreferences;
  String LoginId;
  String _messageText, _messageDate;

  final String URL = "https://oomhen.000webhostapp.com/thaiandjourney_services";

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('Processing...', true);

  _test(String roomId) async {
    await apigetMessageChat(roomId).then((value) {
      if (value[0].message == '1') {
        setState(() {
          _messageText = value.last.mgText;
          _messageDate = value.last.mgModifyDate;
          print(value.last.mgText);
          print(_messageText);
          print(value.last.mgModifyDate);
          print(_messageDate);
          return;
        });
      }
    });
  }

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

  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: TextFormField(
              //     autofocus: false,
              //     onChanged: (v) {},
              //     decoration: InputDecoration(
              //       focusColor: Colors.white,
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Colors.grey,
              //       ),
              //       hintText: 'Search',
              //       hintStyle: TextStyle(
              //         color: Colors.grey,
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //       enabledBorder: Constants.border,
              //       disabledBorder: Constants.border,
              //       border: Constants.border,
              //       errorBorder: Constants.border,
              //       focusedErrorBorder: Constants.border,
              //       focusedBorder: Constants.border,
              //     ),
              //   ),
              // ),
              Container(
                child: Container(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.brown),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/screen/detail_ui');
                          //_test("1");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: FutureBuilder(
                  future: apigetChatRoom(LoginId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data[0].message == '2'){
                        return Text('APP FRIEND');
                      }else{
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ChatRoomScreen(
                                          roomId: snapshot.data[index].roomId,
                                          roomName: snapshot.data[index].roomName,
                                          roomImage: snapshot.data[index].roomImage,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: NetworkImage('${URL}${snapshot.data[index].roomImage}'),
                                        radius: 30.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].roomName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }
}

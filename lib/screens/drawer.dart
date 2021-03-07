import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_tj_v1_3/loginuser/login_ui.dart';



class DrawerAom extends StatefulWidget {
  @override
  _DrawerAomState createState() => _DrawerAomState();
}

class _DrawerAomState extends State<DrawerAom> {
  SharedPreferences sharedPreferences;
  int LoginFlag;
  String LoginEmail, LoginName, LoginId;

  _Logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("LoginFlag", 2);
      sharedPreferences.setString("LoginId", "");
      sharedPreferences.setString("LoginEmail", "");
      sharedPreferences.setString("LoginName", "");
    });
  }

  _getloginFlag() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginFlag = sharedPreferences.getInt("LoginFlag");
      LoginId = sharedPreferences.getString("LoginId");
      LoginEmail = sharedPreferences.getString("LoginEmail");
      LoginName = sharedPreferences.getString("LoginName");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getloginFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/p_5.png',
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(LoginEmail==null?'':LoginEmail),
                          Text(LoginName==null?'':LoginName),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Manage a place'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('LOGOUT'),
            onTap: () {
              //TODO
              _Logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginUI()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}


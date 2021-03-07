import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/loginuser/login_ui.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteUI extends StatefulWidget {
  _FavoriteUIState createState() => _FavoriteUIState();
}

class _FavoriteUIState extends State<FavoriteUI> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getallLocality();
  }

  _Logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("LoginFlag", 2);
    });
  }

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('Processing...', true);
  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services/locality_services";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'FAVORITE',
          style: Constants.titleStyle,
        ),
      ),
      drawer: Drawer(
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
            children: [
              Container(
                height: (500),
                child: FutureBuilder(
                  future: getallLocality(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 0.0,
                          );
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 24.0,
                                ),
                                height: MediaQuery.of(context).size.height * 0.35,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 7,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: InkWell(
                                      onTap: () => () {},
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.95,
                                        child: Image.network(
                                          '${URL}${snapshot.data[index].locImage}',
                                          loadingBuilder:
                                              (context, child, progress) {
                                            return progress == null
                                                ? child
                                                : LinearProgressIndicator(
                                              backgroundColor: Colors.brown,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
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

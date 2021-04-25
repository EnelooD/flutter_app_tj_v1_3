import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/dataillocality_ui.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/screens/drawer.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  SharedPreferences sharedPreferences;
  String LoginId;

  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services";

  int count = 1;
  String roomImage = "/images_user/im_user1.jpg";

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
    getallLocality().then((res) async {
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
    getallLocality().then((res) async {
      _postsController.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _getUserId();

    _postsController = new StreamController();
    super.initState();
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
          'HOME',
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
                      onChanged: (v) {},
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
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
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            print('Has error: ${snapshot.hasError}');
                            print('Has data: ${snapshot.hasData}');
                            print('Snapshot Data ${snapshot.data}');
                            if (snapshot.hasError) {
                              return Text(snapshot.error);
                            }
                            else if(snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                },
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            height: 0,
                                          );
                                        },
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: MediaQuery.of(context).size.height * 0.40,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0, vertical: 10.0),
                                              child: Card(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                elevation: 15,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    print(snapshot.data[index].userId);
                                                    print(snapshot.data[index].locName);
                                                    print(snapshot.data[index].locImage);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return DatailLocalityUI(
                                                            locId: snapshot.data[index].locId,
                                                            userId: snapshot.data[index].userId,
                                                            locName:
                                                            snapshot.data[index].locName,
                                                            locDetails:
                                                            snapshot.data[index].locDetails,
                                                            locImage:
                                                            snapshot.data[index].locImage,
                                                            locPostalcode: snapshot
                                                                .data[index].locPostalcode,
                                                            userName:
                                                            snapshot.data[index].userName,
                                                            userEmail:
                                                            snapshot.data[index].userEmail,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
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
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            else if(snapshot.connectionState != ConnectionState.done) {
                              return progressDialog;
                            }
                            else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                              return Text('No Posts');
                            }
                            else{
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



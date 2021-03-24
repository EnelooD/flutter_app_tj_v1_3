import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/screens2_ui.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatailLocalityUI extends StatefulWidget {
  @override
  _DatailLocalityUIState createState() => _DatailLocalityUIState();

  String locId;
  String locName;
  String locDetails;
  String locImage;
  String locPostalcode;
  String userName;
  String userEmail;

  DatailLocalityUI(
      {this.locId,
      this.locName,
      this.locDetails,
      this.locImage,
      this.locPostalcode,
      this.userName,
      this.userEmail});
}

class _DatailLocalityUIState extends State<DatailLocalityUI> {
  SharedPreferences sharedPreferences;
  String LoginId;

  String showIconFavorite;

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('กำลังประมวลผล...', false);

  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services/locality_services";

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  onGoBack(dynamic value) {
    apigetLocalityFavorite(LoginId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.locName}',
          style: Constants.titleStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (context) => Screens2UI());
            Navigator.push(context, route).then(onGoBack);
          },
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
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          child: Container(
                            width: MediaQuery.of(context).size.height * 1,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Image.network(
                              '${URL}${widget.locImage}',
                              loadingBuilder: (context, child, progress) {
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
                      ],
                    ),

                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Card(
                          color: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              '${widget.locName}',
                                              style: TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: apigetIconFavorite(LoginId, widget.locId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          showIconFavorite = snapshot.data[0].favStatus;
                                          if(snapshot.data[0].message == "2"){
                                            showIconFavorite = "3";
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      if(showIconFavorite == "3"){
                                                        apiInsertFavorite(
                                                            LoginId,
                                                            widget.locId,
                                                            "2"
                                                        ).then((value) {
                                                          if(value == "1"){
                                                            setState(() {
                                                              showIconFavorite = "2";
                                                            });
                                                          }else{
                                                            setState(() {
                                                              showIconFavorite = "1";
                                                            });
                                                          }
                                                        });
                                                      }else{
                                                        if(showIconFavorite == "1"){
                                                          apiUpdateFavorite(
                                                              snapshot.data[0].favId,
                                                              "2"
                                                          ).then((value) {
                                                            if(value == "1"){
                                                              setState(() {
                                                                showIconFavorite = "2";
                                                              });
                                                            }
                                                            else{
                                                              setState(() {
                                                                showIconFavorite = "1";
                                                              });
                                                            }
                                                          });
                                                        }else{
                                                          apiUpdateFavorite(
                                                              snapshot.data[0].favId,
                                                              "1"
                                                          ).then((value) {
                                                            if(value == "1"){
                                                              setState(() {
                                                                showIconFavorite = "1";
                                                              });
                                                            }
                                                            else{
                                                              setState(() {
                                                                showIconFavorite = "2";
                                                              });
                                                            }
                                                          });
                                                        }
                                                      }
                                                    },
                                                    icon: Icon(
                                                      showIconFavorite == "3"
                                                          ? Icons.favorite_outline
                                                          : showIconFavorite == "1"
                                                          ? Icons.favorite_outline
                                                          : Icons.favorite_outlined,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }else{
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      if (snapshot.data[0].favStatus == "1") {
                                                        apiUpdateFavorite(
                                                            snapshot.data[0].favId,
                                                            "2"
                                                        ).then((value) {
                                                          if(value == "1"){
                                                            setState(() {
                                                              showIconFavorite = "2";
                                                            });
                                                          }
                                                          else{
                                                            setState(() {
                                                              showIconFavorite = "1";
                                                            });
                                                          }
                                                        });
                                                      } else {
                                                        apiUpdateFavorite(
                                                            snapshot.data[0].favId,
                                                            "1"
                                                        ).then((value) {
                                                          if(value == "1"){
                                                            setState(() {
                                                              showIconFavorite = "1";
                                                            });
                                                          }
                                                          else{
                                                            setState(() {
                                                              showIconFavorite = "2";
                                                            });
                                                          }
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                      showIconFavorite == "1"
                                                          ? Icons.favorite_outline
                                                          : Icons.favorite_outlined,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        } else {
                                          return progressDialog;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                color: Colors.brown[300],
                                height: MediaQuery.of(context).size.width * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 10.0,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${widget.locDetails} ',
                                      // children: <TextSpan>[
                                      //   TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                                      //   TextSpan(text: ' world!'),
                                      // ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Text(
                                    'userName:${widget.userName}, userEmail:${widget.userEmail}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ),
            progressDialog,
          ],
        ),
      ),
    );
  }
}

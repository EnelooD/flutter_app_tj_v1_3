import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/managelocality/localityregister_ui.dart';
import 'package:flutter_app_tj_v1_3/screens2_ui.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';

class ManagePlaceUI extends StatefulWidget {
  @override
  _ManagePlaceUIState createState() => _ManagePlaceUIState();
}

class _ManagePlaceUIState extends State<ManagePlaceUI> {
  SharedPreferences sharedPreferences;
  String LoginId;

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('Processing...', true);
  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services/locality_services";

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
    });
  }

  Future<void> showAlert(String msgTitle, String msgContent) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4.0,
            ),
          ),
          title: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.brown,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          msgTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  msgContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.brown,
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.brown),
                    ),
                    child: Text(
                      'ตกลง',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'MANAGE A PLACE',
          style: Constants.titleStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.home,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Screens2UI()),
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 70),
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
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FutureBuilder(
                future: apigetLocalityManage(LoginId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data[0].message == "2"){
                      return Text("NOT HAS DATA");
                    }else{
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 0,
                          );
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height:
                            MediaQuery.of(context).size.height * 0.45,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Stack(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return DatailLocalityUI(
                                        //         locId: snapshot.data[index].locId,
                                        //         userId: snapshot.data[index].userId,
                                        //         locName:
                                        //         snapshot.data[index].locName,
                                        //         locDetails:
                                        //         snapshot.data[index].locDetails,
                                        //         locImage:
                                        //         snapshot.data[index].locImage,
                                        //         locPostalcode: snapshot
                                        //             .data[index].locPostalcode,
                                        //       );
                                        //     },
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.height * 0.45,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        child: Image.network(
                                          '${URL}${snapshot.data[index].locImage}',
                                          loadingBuilder:
                                              (context, child, progress) {
                                            return progress == null
                                                ? child
                                                : LinearProgressIndicator(
                                              backgroundColor:
                                              Colors.brown,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LocalityRegisterUI();
              },
            ),
          );
        },
        backgroundColor: Colors.brown[800],
        child: Icon(
          Icons.add_circle,
        ),
      ),
    );
  }
}

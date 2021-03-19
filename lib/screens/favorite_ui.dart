import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/drawer.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoriteUI extends StatefulWidget {
  _FavoriteUIState createState() => _FavoriteUIState();
}

class _FavoriteUIState extends State<FavoriteUI> {
  SharedPreferences sharedPreferences;
  String LoginId;

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserId();
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
      drawer: DrawerAom(),
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
                future: apigetLocalityFavorite(LoginId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                          MediaQuery.of(context).size.height * 0.40,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Stack(
                              children: [
                                Card(
                                  clipBehavior:
                                  Clip.antiAliasWithSaveLayer,
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
    );
  }
}

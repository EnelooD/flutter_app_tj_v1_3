import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/dataillocality_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/drawer.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('Processing...', true);
  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services/locality_services";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _test() {
    print ("AAAAA");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAom(),
      extendBodyBehindAppBar: true,
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
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
                          _test();
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
                  future: getallLocality(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data[0].message == '2'){
                        return Text('NOT DAS DATA');
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return DatailLocalityUI(
                                              locId: snapshot.data[index].locId,
                                              locName: snapshot.data[index].locName,
                                              locDetails: snapshot.data[index].locDetails,
                                              locImage: snapshot.data[index].locImage,
                                              locPostalcode: snapshot.data[index].locPostalcode,
                                              userName: snapshot.data[index].userName,
                                              userEmail: snapshot.data[index].userEmail,
                                            );
                                          },
                                        ),
                                      );
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

import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';

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
  String _radioStatus;
  TextEditingController _tecName; //= TextEditingController();
  TextEditingController _tecEmail; //= TextEditingController();
  TextEditingController _tecAge; //= TextEditingController();
  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('กำลังประมวลผล...', false);

  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services/locality_services";

  _handleRadioValueChange(String value) {
    setState(() {
      _radioStatus = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //_tecName = TextEditingController(text: widget.locName);
    //_tecEmail = TextEditingController(text: widget.locName);
    //_tecAge = TextEditingController(text: widget.userId);
    //_radioStatus = widget.status;
    super.initState();
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
            Navigator.pop(context);
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
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Text(
                                    '${widget.locName}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
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
                                  child: Row(
                                    children: [
                                      Text(
                                        '${widget.locDetails}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                      height: 50.0,
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

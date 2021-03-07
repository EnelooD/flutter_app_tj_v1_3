import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/progress_dialog.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';

class DatailLocalityUI extends StatefulWidget {
  @override
  _DatailLocalityUIState createState() => _DatailLocalityUIState();

  String locId;
  String userId;
  String locName;
  String locDetails;
  String locImage;
  String locPostalcode;

  DatailLocalityUI(
      {this.locId,
      this.userId,
      this.locName,
      this.locDetails,
      this.locImage,
      this.locPostalcode});
}

class _DatailLocalityUIState extends State<DatailLocalityUI> {
  String _radioStatus;
  TextEditingController _tecName; //= TextEditingController();
  TextEditingController _tecEmail; //= TextEditingController();
  TextEditingController _tecAge; //= TextEditingController();
  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog('กำลังประมวลผล...', false);

  final String URL = "https://oomhen.000webhostapp.com/thaiandjourney_services/locality_services";

  _handleRadioValueChange(String value) {
    setState(() {
      _radioStatus = value;
    });
  }

  Future<void> _showWarningDialog(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คำเตือน'),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          '${widget.locName}',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
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
                              height:
                                  MediaQuery.of(context).size.width * 0.5,
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
                                  'userName:${widget.userId}, userEmail:${widget.userId}',
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
                    height: 24.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          onPressed: () async {
                            // if (_tecName.text.trim().length == 0) {
                            //   _showWarningDialog(context, 'ตรวจสอบการป้อนชื่อ...');
                            // } else if (_tecEmail.text.trim().length == 0) {
                            //   _showWarningDialog(context, 'ตรวจสอบการป้อนอีเมล์...');
                            // } else {
                            //   //Send data to server for save on database
                            //   progressDialog.showProgress();
                            //   String message = await updatefriend(
                            //       widget.locId,
                            //       _tecName.text,
                            //       _tecEmail.text,
                            //       _tecAge.text,
                            //       _radioStatus);
                            //   print(message);
                            //   if (message == '1') {
                            //     setState(() {
                            //       progressDialog.hideProgress();
                            //       Navigator.pop(context);
                            //     });
                            //   }
                            // }
                          },
                          height: 55.0,
                          color: Colors.blue,
                          child: Text(
                            'แก้ไข',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () async {
                            showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('ยืนยัน'),
                                    titleTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                    content: Text('ยืนยันการลบ ?'),
                                    actions: <Widget>[
                                      RaisedButton(
                                        child: Text(
                                          'ตกลง',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () async {
                                          // progressDialog.showProgress();
                                          // String message = await deletefriend(widget.locId);
                                          // print(message);
                                          // if (message == '1') {
                                          //   setState(() {
                                          //     progressDialog.hideProgress();
                                          //     Navigator.pop(context);
                                          //   });
                                          // }
                                          // Navigator.pop(context);
                                        },
                                        color: Colors.green,
                                      ),
                                      RaisedButton(
                                        child: Text(
                                          'ยกเลิก',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        color: Colors.deepOrange,
                                      ),
                                    ],
                                  );
                                });
                          },
                          height: 55.0,
                          color: Colors.deepOrange,
                          child: Text(
                            'ลบ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          progressDialog,
        ],
      ),
    );
  }
}

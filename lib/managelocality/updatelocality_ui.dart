import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/managelocality/homemanage.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpDateLocality_UI extends StatefulWidget {
  @override
  _UpDateLocality_UIState createState() => _UpDateLocality_UIState();

  String locId;
  String locName;
  String locDetails;
  String locImage;


  UpDateLocality_UI(
      {this.locId,
        this.locName,
        this.locDetails,
        this.locImage});

}

class _UpDateLocality_UIState extends State<UpDateLocality_UI> {
  SharedPreferences sharedPreferences;
  String LoginId;

  TextEditingController locName; //= TextEditingController();
  TextEditingController locDetails; //= TextEditingController();
  TextEditingController locImage; //= TextEditingController();

  //import 'dart:io';
  File _selectImage;
  String _selectImageBase64 = '';
  String _selectImageName = '';


  final String URL =
      "https://oomhen.000webhostapp.com/thaiandjourney_services";

  _selectImageFromCamera() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 75);

    if (pickedFile == null) return;
    setState(() {
      _selectImage = File(pickedFile.path);
      _selectImageBase64 = base64Encode(_selectImage.readAsBytesSync());
      _selectImageName = _selectImage.path.split('/').last;
    });
  }

  _selectImageFromGallery() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile == null) return;
    setState(() {
      _selectImage = File(pickedFile.path);
      _selectImageBase64 = base64Encode(_selectImage.readAsBytesSync());
      _selectImageName = _selectImage.path.split('/').last;
    });
  }

  _showSelectFromCamGal(context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _selectImageFromCamera();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.brown,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _selectImageFromGallery();
                  },
                  child: Icon(
                    Icons.camera,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
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

  Future<void> showAlertCreate(String msgTitle, String msgContent) {
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
                      Route route = MaterialPageRoute(builder: (context) => ManagePlaceUI());
                      Navigator.push(context, route).then(onGoBack);
                      apiUpdateLocalityService(
                        widget.locId,
                        locName.text,
                        locDetails.text,
                        _selectImageName,
                        _selectImageBase64,
                      );
                    },
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown),
                    ),
                    child: Text(
                      'ยกเลิก',
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

  _checkCreate() async {
    if (locName.text.trim().length == 0) {
      showAlert('คำเตือน', 'ลืมป้อน locName หรือเปล่าจ๊ะ');
    } else if (locDetails.text.trim().length == 0) {
      showAlert('คำเตือน', 'locDetails');
    } else {
      showAlertCreate("ยืนยัน", "ต้องการยืนยันการแก้ไข");
    }
  }

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
    });
  }

  void initState() {
    // TODO: implement initState
    locName = TextEditingController();
    locDetails = TextEditingController();
    locImage = TextEditingController();
    _getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('LOCALITY REGISTER'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  'Edit My Locality',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 5,
                          color: Colors.brown[400],
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: Colors.brown,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _selectImage == null
                              ? NetworkImage('${URL}${widget.locImage}')
                              : FileImage(_selectImage),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        //color: Colors.black,
                      ),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: IconButton(
                          onPressed: () {
                            _showSelectFromCamGal(context);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0, left: 60.0),
                  child: TextFormField(
                    controller: locName,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      prefixIcon: Icon(
                        Icons.location_history,
                        color: Colors.brown,
                      ),
                      hintText: widget.locName,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0, left: 60.0),
                  child: TextFormField(
                    controller: locDetails,
                    minLines: 4,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: widget.locDetails,
                      prefixIcon: Icon(
                        Icons.description_rounded,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown),
                    ),
                    onPressed: () {
                      // print('${locName}');
                      // print('${locDetails}');
                      // print('${_selectImageName}');
                      // print('${_selectImageBase64}');
                      _checkCreate();
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onGoBack(dynamic value) {
    apigetLocalityManage(LoginId);
    setState(() {});
  }
}

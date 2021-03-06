import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_tj_v1_3/managelocality/homemanage.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalityRegisterUI extends StatefulWidget {
  @override
  _LocalityRegisterUIState createState() => _LocalityRegisterUIState();
}

class _LocalityRegisterUIState extends State<LocalityRegisterUI> {
  SharedPreferences sharedPreferences;
  String LoginId;
  TextEditingController locName; //= TextEditingController();
  TextEditingController locDetails; //= TextEditingController();
  TextEditingController locPostalcode; //= TextEditingController();
  TextEditingController locImage; //= TextEditingController();
  TextEditingController locLat; //= TextEditingController();
  TextEditingController locLong; //= TextEditingController();
  String userId;
  String locStatus;

  //import 'dart:io';
  File _selectImage;
  String _selectImageBase64 = '';
  String _selectImageName = '';

  @override
  bool checkBoxValue = false;

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

  _getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginId = sharedPreferences.getString("LoginId");
      userId = LoginId;
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
                      '????????????',
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
                      '????????????',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagePlaceUI()),
                        (Route<dynamic> route) => false,
                      );
                      apiRegisterLocalityService(
                        userId,
                        locName.text,
                        locDetails.text,
                        locPostalcode.text,
                        locStatus,
                        _selectImageName,
                        _selectImageBase64,
                        locLat.text,
                        locLong.text,
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
                      '??????????????????',
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
      showAlert('?????????????????????', '????????????????????? locName ????????????????????????????????????');
    } else if (locDetails.text.trim().length == 0) {
      showAlert('?????????????????????', 'locDetails');
    } else if (locPostalcode.text.trim().length < 5) {
      showAlert('?????????????????????', 'locPostalcode');
    } else if (_selectImageName.length == 0) {
      showAlert('?????????????????????', '????????????????????????');
    } else if (locLat.text.trim().length == 0) {
      showAlert('?????????????????????', 'locLat');
    } else if (locLong.text.trim().length == 0) {
      showAlert('?????????????????????', 'locLong');
    } else if (checkBoxValue == false) {
      showAlert('?????????????????????', 'checkBoxValue');
    }else {
      showAlertCreate("??????????????????", "???????????????????????????????????????????????????????????????????????????");
    }
  }

  void initState() {
    // TODO: implement initState
    _getUserId();
    locStatus = '1';
    locName = TextEditingController();
    locDetails = TextEditingController();
    locPostalcode = TextEditingController();
    locImage = TextEditingController();
    locLat = TextEditingController();
    locLong = TextEditingController();
    super.initState();
  }

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
                  'Create My Locality',
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
                              ? AssetImage("assets/images/brown.jpg")
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
                      hintText: 'Locality Name',
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
                    minLines: 1,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Locality Details',
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60.0,
                    right: 60.0,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[0-9]+"),
                      ),
                    ],
                    controller: locPostalcode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.brown,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      hintText: 'Locality Pastalcode',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: locLat,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.language_rounded,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            hintText: 'Latitude',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: locLong,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.language_rounded,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            hintText: 'Longitude',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Checkbox(
                        value: checkBoxValue,
                        activeColor: Colors.brown,
                        onChanged: (bool detailValue) {
                          setState(() {
                            checkBoxValue = detailValue;
                          });
                        }),
                    GestureDetector(
                      child: Text.rich(
                        TextSpan(
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'I agree all statements ',
                              style: TextStyle(
                                color: Colors.brown,
                              ),
                            ),
                            TextSpan(
                              text: 'terms of service',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/localityregister');
                      },
                    ),
                  ],
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
                      // print('${userId}');
                      // print('${locStatus}');
                      // print('${locName}');
                      // print('${locDetails}');
                      // print('${locPostalcode}');
                      // print('${_selectImageName}');
                      // print('${_selectImageBase64}');
                      // print('${locLat}');
                      // print('${locLong}');
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
}

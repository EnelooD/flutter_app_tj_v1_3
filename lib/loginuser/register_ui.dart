import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/loginuser/login_ui.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {

  TextEditingController userName; //= TextEditingController();
  TextEditingController userEmail; //= TextEditingController();
  TextEditingController userPassword; //= TextEditingController();
  TextEditingController userConPassword; //= TextEditingController();
  TextEditingController userImage; //= TextEditingController();
  String userStatus;

  @override
  bool showPassword = true;
  bool showConpassword = true;
  bool checkBoxValue = false;

  //import 'dart:io';
  File _selectImage;
  String _selectImageBase64 = '';
  String _selectImageName = '';

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
                        MaterialPageRoute(builder: (context) => LoginUI()),
                            (Route<dynamic> route) => false,
                      );
                      apiRegisterService(
                        userName.text.trim(),
                        userEmail.text.trim(),
                        userPassword.text.trim(),
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

  _checkCreate() async {

    if (userName.text.trim().length == 0) {
      showAlert('?????????????????????', '????????????????????? Username ????????????????????????????????????');
    }else if (userEmail.text.trim().length == 0) {
      showAlert('?????????????????????', '????????????????????? Email ????????????????????????????????????');
    }else if (userPassword.text.trim().length < 6) {
      showAlert('?????????????????????', 'Password ???????????? 6 ??????????????????????????????????????????');
    }else if (userConPassword.text.trim().length < 6) {
      showAlert('?????????????????????', 'Confirm Password ???????????? 6 ??????????????????????????????????????????');
    }else if (userPassword.text.trim() != userConPassword.text.trim()) {
      showAlert('?????????????????????', 'Password ??????????????????????????????????????? Confirm Password');
    }else if (checkBoxValue == false) {
      showAlert('?????????????????????', 'checkBoxValue');
    }else{
      showAlertCreate("??????????????????", "???????????????????????????????????????????????????????????????????????????");
    }
  }

  void initState() {
    // TODO: implement initState
    userStatus = '1';
    userName = TextEditingController();
    userEmail = TextEditingController();
    userPassword = TextEditingController();
    userConPassword = TextEditingController();
    userImage = TextEditingController();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('REGISTER'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Text(
                'Create account',
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
                  controller: userName,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    prefixIcon: Icon(
                      Icons.location_history,
                      color: Colors.brown,
                    ),
                    hintText: 'User Name',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 60.0, left: 60.0),
                child: TextFormField(
                  controller: userEmail,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.brown,
                    ),
                    hintText: 'E-mail',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 60.0,
                  right: 60.0,
                ),
                child: TextFormField(
                  controller: userPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.brown,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (showPassword == true) {
                          setState(() {
                            showPassword = false;
                          });
                        } else {
                          setState(() {
                            showPassword = true;
                          });
                        }
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: showPassword,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 60.0,
                  right: 60.0,
                ),
                child: TextFormField(
                  controller: userConPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.brown,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (showConpassword == true) {
                          setState(() {
                            showConpassword = false;
                          });
                        } else {
                          setState(() {
                            showConpassword = true;
                          });
                        }
                      },
                      icon: Icon(
                        showConpassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: showConpassword,
                ),
              ),
              SizedBox(
                height: 15,
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
                        Text('Remember me');
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
                      Navigator.pushNamed(context, '/detailregister_ui');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 80,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.brown),
                  ),
                  onPressed: (){
                    //print('${userStatus}');
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
            ],
          ),
        ),
      ),
    );
  }
}

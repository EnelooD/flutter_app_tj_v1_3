import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/loginuser/login_ui.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {

  TextEditingController userName; //= TextEditingController();
  TextEditingController userEmail; //= TextEditingController();
  TextEditingController userPassword; //= TextEditingController();
  TextEditingController userConPassword; //= TextEditingController();
  String userStatus;

  @override
  bool showPassword = true;
  bool showConpassword = true;
  bool checkBoxValue = false;


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

  _checkCreate() async {

    if (userName.text.trim().length == 0) {
      showAlert('คำเตือน', 'ลืมป้อน Username หรือเปล่าจ๊ะ');
      return;
    }

    if (userEmail.text.trim().length == 0) {
      showAlert('คำเตือน', 'ลืมป้อน Email หรือเปล่าจ๊ะ');
      return;
    }

    if (userPassword.text.trim().length < 6) {
      showAlert('คำเตือน', 'Password ต้อง 6 ตัวขึ้นไปนะจ๊ะ');
      return;
    }

    if (userConPassword.text.trim().length < 6) {
      showAlert('คำเตือน', 'Confirm Password ต้อง 6 ตัวขึ้นไปนะจ๊ะ');
      return;
    }

    if (userPassword.text.trim() != userConPassword.text.trim()) {
      showAlert('คำเตือน', 'Password ต้องเหมือนกัน Confirm Password');
      return;
    }

    if (checkBoxValue == false) {
      showAlert('คำเตือน', 'checkBoxValue');
      return;
    }

    await apiregisterService(
      userName.text.trim(),
      userEmail.text.trim(),
      userPassword.text.trim(),
      userStatus,
    ).then((value) {
      print(value.toString());
      if (value == '1') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginUI()),
              (Route<dynamic> route) => false,
        );
      }
      if (value == '2') {
        showAlert('ผลการทำงาน', 'Username Password ไม่ถูกต้อง');
      }
      if (value == '3') {
        showAlert('คำเตือน', 'มีความผิดพลาดในการทำงานกรุณาลองใหม่อีกครั้ง');
      }
    });
  }

  void initState() {
    // TODO: implement initState
    userStatus = '1';
    userName = TextEditingController();
    userEmail = TextEditingController();
    userPassword = TextEditingController();
    userConPassword = TextEditingController();

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
                height: 45,
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
                    hintText: 'User ID',
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

import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens2_ui.dart';
import 'package:flutter_app_tj_v1_3/screens_ui.dart';
import 'package:flutter_app_tj_v1_3/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override

  bool showVisible = true;

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

  SharedPreferences sharedPreferences;
  int LoginFlag;

  _setloginFlag(String LoginEmail, String LoginName, String LoginId) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("LoginFlag", 1);
      sharedPreferences.setString("LoginId", LoginId);
      sharedPreferences.setString("LoginName", LoginName);
      sharedPreferences.setString("LoginEmail", LoginEmail);
    });
  }

  _getloginFlag() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LoginFlag = sharedPreferences.getInt("LoginFlag");
      if (LoginFlag == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return Screens2UI();
            }),
          ),
        );
      }
    });
  }

  _checkLogoin() async {
    if (userEmail.text.trim().length == 0) {
      showAlert('คำเตือน', 'ลืมป้อน Username หรือเปล่าจ๊ะ');
      return;
    }

    if (userPassword.text.trim().length < 6) {
      showAlert('คำเตือน', 'Password ต้อง 6 ตัวขึ้นไปนะจ๊ะ');
      return;
    }

    await apiLoginService(
      userEmail.text.trim(),
      userPassword.text.trim(),
    ).then((value) {
      print(value.toString());
      if (value[0].message == '1') {
        _setloginFlag(value[0].userEmail, value[0].userName, value[0].userId);
        // getMember(
        //   userEmail.text.trim(),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return Screens2UI();
            }),
          ),
        );
      }
      if (value[0].message == '2') {
        showAlert('ผลการทำงาน', 'Username Password ไม่ถูกต้อง');
      }
      if (value[0].message == '3') {
        showAlert('คำเตือน', 'มีความผิดพลาดในการทำงานกรุณาลองใหม่อีกครั้ง');
      }
    });
  }

  _dismisskeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    // TODO: implement initState
    _getloginFlag();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset(
                  'assets/images/p_5.png',
                  height: 150,
                ),
              ),
              SizedBox(
                height: 30,
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
                      Icons.location_history,
                      color: Colors.brown,
                    ),
                    hintText: 'User ID',
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                        if (showVisible == true) {
                          setState(() {
                            showVisible = false;
                          });
                        } else {
                          setState(() {
                            showVisible = true;
                          });
                        }
                      },
                      icon: Icon(
                        showVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: showVisible,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.brown),
                      ),
                      onPressed: () {
                        //TODO
                        _dismisskeyboard(context);
                        _checkLogoin();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.brown),
                      ),
                      onPressed: () {
                         _dismisskeyboard(context);
                        setState(() {
                          userPassword.text = '';
                          userEmail.text = '';
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Text.rich(
                      TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Create Account?  ',
                            style: TextStyle(
                              color: Colors.brown,
                            ),
                          ),
                          TextSpan(
                            text: 'Click',
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
                      setState(() {
                        userPassword.text = '';
                        userEmail.text = '';
                      });
                      Navigator.pushNamed(context, '/register_ui');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

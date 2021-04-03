import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/models/message.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';


class ChatInput extends StatefulWidget {
  final Function onPressed;
  ChatInput({this.onPressed});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController mgText = TextEditingController();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[900],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 150.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.insert_emoticon),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Please enter the message',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.brown[500],
                enabledBorder: Constants.border,
                disabledBorder: Constants.border,
                border: Constants.border,
                errorBorder: Constants.border,
                focusedErrorBorder: Constants.border,
                focusedBorder: Constants.border,
              ),
              onChanged: (mgText) {
                mgText = mgText;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: RawMaterialButton(
              onPressed: () {
                setState(() {
                  widget.onPressed(mgText);
                  _controller.text = '';
                });
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
              fillColor: Colors.brown[500],
              shape: CircleBorder(),
              elevation: 0.0,
            ),
            constraints: BoxConstraints(
              maxWidth: 40,
              maxHeight: 40,
            ),
          )
        ],
      ),
    );
  }
}

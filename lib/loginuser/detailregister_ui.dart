import 'package:flutter/material.dart';

class DetailregisterUI extends StatefulWidget {
  @override
  _DetailregisterUIState createState() => _DetailregisterUIState();
}

class _DetailregisterUIState extends State<DetailregisterUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Detailregister',
        ),
        centerTitle: true,
      ),
    );
  }
}

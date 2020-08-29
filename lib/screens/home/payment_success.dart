import 'package:flutter/material.dart';

class PaySuc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Now'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/Payment_Successful.gif')
          ],
        ),
      ),
    );
  }
}

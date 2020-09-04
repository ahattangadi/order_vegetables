import 'package:flutter/material.dart';

String _address =
    'XYZ, XYZ House, UIH Road, Natak Bazaar, Mumbai, Maharashtra -29';
String _phoneNumber = '9809802900';
String _emailAddress = 'support.flutter.app@ordervegetables.com';

void main(List<String> args) {
  runApp(ContactScreen());
}

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text('Contact Us'),
          backgroundColor: Colors.brown[400],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/images/Logo.png'),
              SizedBox(
                height: 40.0,
              ),
              Text(
                  'Contact Us: \n Address: ${_address} \n Phone Number: ${_phoneNumber} \n Email Address: ${_emailAddress} '),
            ],
          ),
        ),
      ),
    );
  }
}

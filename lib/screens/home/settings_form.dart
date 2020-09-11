import 'package:flutter/material.dart';
import 'package:order_vegetables/models/user.dart';
import 'package:order_vegetables/services/database.dart';
import 'package:order_vegetables/shared/constants.dart';
import 'package:order_vegetables/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentOrder;
  String _currentAddress;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Create a new order',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Your Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.order,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Your Order'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your order' : null,
                      onChanged: (val) => setState(() => _currentOrder = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.address,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Your Address and Phone Number'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your address' : null,
                      onChanged: (val) => setState(() => _currentAddress = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentOrder ?? userData.order,
                              _currentAddress ?? userData.address);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

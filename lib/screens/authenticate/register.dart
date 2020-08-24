import 'dart:io';

import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/authenticate/sign_in.dart';
import 'package:order_vegetables/services/auth.dart';
import 'package:order_vegetables/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              centerTitle: true,
              title: Text('Sign up to Order Vegetables'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign in'))
              ],
            ),
            body: Center(
              child: Container(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Enter an e-mail. This field cannot be left empty'
                                  : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                              ),
                              validator: (val) => val.length < 6
                                  ? 'Enter a password with more than 6 characters.'
                                  : null,
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                              color: Colors.pink[400],
                              child: Text(
                                'Sign up',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'An error has occured while trying to create your account. Please check that you have entered a vaild e-mail and strong password. If you have, please try again later';
                                      loading = false;
                                    });
                                  }
                                }
                              }),
                          SizedBox(height: 12.0),
                          Text(error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0))
                        ],
                      )),
                ),
              ),
            ));
  }
}

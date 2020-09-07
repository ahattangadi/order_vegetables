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
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(295.0, 110.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNovaBlack',
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
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
                          height: 40.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          child: RaisedButton(
                              color: Colors.green,
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNovaBlack'),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90.0)),
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
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 140.0,
                        ),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontFamily: 'ProximaNovaEB'),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'ProximaNovaEB',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

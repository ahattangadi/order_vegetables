import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/authenticate/register.dart';
import 'package:order_vegetables/services/auth.dart';
import 'package:order_vegetables/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        : SafeArea(
            child: Scaffold(
                backgroundColor: Colors.brown[100],
                appBar: AppBar(
                  backgroundColor: Colors.brown[400],
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text('Sign in to Order Vegetables'),
                  actions: <Widget>[
                    FlatButton.icon(
                        onPressed: () {
                          widget.toggleView();
                        },
                        icon: Icon(Icons.person),
                        label: Text('Sign up'))
                  ],
                ),
                body: Center(
                  child: Container(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
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
                                    'Sign in',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'An error has occured while trying to log in. Either you have entered incorrect credentials or your account does not exist.';
                                          loading = false;
                                        });
                                      }
                                    }
                                  }),
                              SizedBox(height: 12.0),
                              Text(error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0)),
                              SizedBox(
                                height: 12.0,
                              ),
                            ],
                          )),
                    ),
                  ),
                )),
          );
  }
}

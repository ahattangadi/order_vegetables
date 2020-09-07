import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/authenticate/register.dart';
import 'package:order_vegetables/screens/home/home.dart';
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
            child: MaterialApp(
                home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                        child: Text('Hello',
                            style: TextStyle(
                                fontFamily: 'ProximaNovaBlack',
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 190, 0, 0),
                        child: Text('There',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontFamily: 'ProximaNovaBlack',
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(250.0, 190.0, 0.0, 0.0),
                        child: Text('.',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontFamily: 'ProximaNovaBlack',
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      )
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
                              labelText: 'Email',
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
                            decoration: InputDecoration(labelText: 'Password'),
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
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'SFPro'),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
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
                        ),
                        SizedBox(height: 12.0),
                        Text(error,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.0)),
                        SizedBox(
                          height: 140.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have a account?',
                      style: TextStyle(fontFamily: 'ProximaNovaEB'),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          fontFamily: 'ProximaNovaEB',
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )));
  }
}

import 'package:flutter/material.dart';
import 'package:order_vegetables/services/auth.dart';
import 'package:order_vegetables/services/database.dart';
import 'package:provider/provider.dart';
import 'package:order_vegetables/screens/home/order_list.dart';
import 'package:order_vegetables/models/orders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Orders>>.value(
      value: DatabaseService().orders,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Order Vegetables'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Sign out'),
            )
          ],
        ),
        body: Container(child: OrderList()),
      ),
    );
  }
}

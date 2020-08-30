import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/home/payment_screen.dart';
import 'package:order_vegetables/screens/home/settings_form.dart';
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

  int _currentIndex = 0;
  final tabs = [
    Container(child: OrderList()),
    PaymentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm(),
              ),
            );
          });
    }

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
            ),
          ],
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              title: Text('Pay Now!'),
              backgroundColor: Colors.blue,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showSettingsPanel(),
          child: Icon(Icons.create),
          backgroundColor: Colors.brown[400],
        ),
      ),
    );
  }
}

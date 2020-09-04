import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/home/chat.dart';
import 'package:order_vegetables/screens/home/complaint.dart';
import 'package:order_vegetables/screens/home/payment_screen.dart';
import 'package:order_vegetables/screens/home/rating.dart';
import 'package:order_vegetables/screens/home/settings_form.dart';
import 'package:order_vegetables/services/auth.dart';
import 'package:order_vegetables/services/database.dart';
import 'package:provider/provider.dart';
import 'package:order_vegetables/screens/home/order_list.dart';
import 'package:order_vegetables/models/orders.dart';
import 'package:order_vegetables/screens/home/contact.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
    ContactScreen(),
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
          backgroundColor: Colors.teal[500],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text(
                'Sign out',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        body: Scaffold(
          body: tabs[_currentIndex],
          backgroundColor: Colors.tealAccent[50],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.tealAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              title: Text('Pay Now!'),
              backgroundColor: Colors.tealAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              backgroundColor: Colors.tealAccent,
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
          child: Icon(Icons.add_shopping_cart),
          backgroundColor: Colors.tealAccent[300],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Image.asset('assets/images/Logo.png')),
              ListTile(
                  title: Text('Home'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }),
              ListTile(
                  title: Text('Pay Now'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                  }),
              ListTile(
                  title: Text('Contact Us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactScreen()),
                    );
                  }),
              ListTile(
                  title: Text('File a complaint'),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintScreen()));
                    /*const url = "https://form.jotform.com/202471852266052";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                     WebView(
                      initialUrl: 'https://form.jotform.com/202471852266052',
                      javascriptMode: JavascriptMode.unrestricted,
                    ); */
                  }),
              ListTile(
                title: Text('Help'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Rate Us!'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RatingScreen()),
                  );
                },
              ),
              ListTile(
                title: Text(
                    '(C) 2020, Order Vegetables \n All Rights Reserved \n Open  Source Code \n Written in Flutter by Aarav'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

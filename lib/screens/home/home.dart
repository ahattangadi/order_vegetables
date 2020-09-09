import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/home/chat.dart';
import 'package:order_vegetables/screens/home/complaint.dart';
import 'package:order_vegetables/screens/home/payment_screen1.dart';
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
import 'home1.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int _currentIndex = 0;
  final tabs = [
    /* Container(
      child: OrderList(),
    ),*/
    Home1(),
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

    void _showHelpPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      const url1 =
                          "https://tawk.to/chat/5f5212f24704467e89ec2596/default";
                      if (await canLaunch(url1)) {
                        await launch(
                          url1,
                        );
                      } else {
                        throw 'Could not launch $url1';
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text('Initiate a Live Chat'),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      const mailAdd =
                          'mailto:aarav@hattangadi.com?subject=Help Requested from App';

                      try {
                        await launch(mailAdd);
                      } catch (e) {
                        Toast.show(
                            'Error sending email. Please write a email to aarav@hattangadi.com',
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text('Email Us'),
                  ),
                  //
                  SizedBox(
                    height: 40.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      const phoneAdd = 'tel:+919809802900';

                      try {
                        await launch(phoneAdd);
                      } catch (e) {
                        Toast.show(
                            'Error calling. Please Call +91 980 980 2900',
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text('Call Us'),
                  ),
                  //
                  SizedBox(
                    height: 40.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      const smsAdd = 'sms:+919809802900';

                      try {
                        await launch(smsAdd);
                      } catch (e) {
                        Toast.show(
                            'Error sending sms. Please send one to +91 98203 41433',
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text('SMS us'),
                  ),
                ],
              ),
            );
          });
    }

    void _showAboutDialog() {
      showAboutDialog(
        context: context,
        applicationName: 'Order Vegetables',
        applicationVersion: '1.8.0',
        applicationLegalese:
            '(C) 2020 — Aarav Hattangadi \n Made with Flutter-Firebase',
      );
    }

    return StreamProvider<List<Orders>>.value(
      value: DatabaseService().orders,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Order Vegetables'),
          backgroundColor: Colors.green,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text(
                'Sign out',
                style: TextStyle(color: Colors.white),
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
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Pay Now!',
              backgroundColor: Colors.tealAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'Contact Us',
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
          backgroundColor: Colors.green,
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
              ListTile(title: Text('Help'), onTap: () => _showHelpPanel()),
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
                title: Text('Sign Out'),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
              ListTile(
                title: Text('About Us'),
                onTap: () => _showAboutDialog(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

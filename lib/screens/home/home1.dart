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

class Home1 extends StatefulWidget {
  @override
  _HomeState1 createState() => _HomeState1();
}

class _HomeState1 extends State<Home1> {
  final AuthService _auth = AuthService();

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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[900],
          body: Stack(
            children: [
              Wrap(
                children: [
                  Stack(children: <Widget>[
                    Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'ProximaNovaBold',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      child: SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                color: Colors.white),
                            child: OrderList()),
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

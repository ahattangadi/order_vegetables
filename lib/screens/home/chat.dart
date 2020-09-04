import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Get Help'),
        ),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  RaisedButton(
                      child: Text("Open Live Chat"),
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
                          borderRadius: new BorderRadius.circular(30.0))),
                  RaisedButton(
                      child: Text("Send us a Message"),
                      onPressed: () async {
                        const url2 = "";
                        if (await canLaunch(url2)) {
                          await launch(url2);
                        } else {
                          throw 'Could not launch $url2';
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

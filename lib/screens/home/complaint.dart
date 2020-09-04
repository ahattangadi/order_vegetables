import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ComplaintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text('File a Complaint'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Container(
              child: InAppWebView(
                initialUrl: 'https://form.jotform.com/202471852266052',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

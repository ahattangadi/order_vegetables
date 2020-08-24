import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<QuerySnapshot>(context);
    //print(brews.documents);
    if (orders != null) {
      for (var doc in orders.documents) {
        print(doc.data);
      }
    }

    Widget build(BuildContext context) {
      return Container();
    }
  }
}

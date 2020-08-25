import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:order_vegetables/models/orders.dart';
import 'order_tile.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Orders>>(context) ?? [];

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderTile(order: orders[index]);
      },
    );
  }
}

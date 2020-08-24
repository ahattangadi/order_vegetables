import 'package:flutter/material.dart';
import 'package:order_vegetables/models/orders.dart';

class OrderTile extends StatelessWidget {
  final Orders order;
  OrderTile({this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(order.name),
          subtitle: Text('Your Order: ${order.order}'),
        ),
      ),
    );
  }
}

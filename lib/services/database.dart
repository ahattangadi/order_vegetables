import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_vegetables/models/orders.dart';
import 'package:order_vegetables/models/orders.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// collection reference
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  Future updateUserData(String name, String order, String address) async {
    return await orderCollection.document(uid).setData({
      'name': name,
      'order': order,
      'address': address,
    });
  }

// order list from snapshot
  List<Orders> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Orders(
        name: doc.data['name'] ?? '',
        order: doc.data['order'] ?? '',
        address: doc.data['address'] ?? '',
      );
    }).toList();
  }

//todo: implement get orders stream in employee app
// get orders stream
  Stream<List<Orders>> get orders {
    return orderCollection.snapshots().map(_ordersListFromSnapshot);
  }
}

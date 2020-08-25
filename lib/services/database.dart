import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_vegetables/models/orders.dart';
import 'package:order_vegetables/models/orders.dart';
import 'package:order_vegetables/models/user.dart';

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

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      order: snapshot.data['order'],
      address: snapshot.data['address'],
    );
  }

//todo: implement get orders stream in employee app
// get orders stream
  Stream<List<Orders>> get orders {
    return orderCollection.snapshots().map(_ordersListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return orderCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}

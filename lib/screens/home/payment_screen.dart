import 'package:flutter/material.dart';
import 'package:order_vegetables/screens/home/payment_success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_83ERzeBOqAsuYo",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Order Vegetables",
      "description": "Payment for order; ordered from Order Vegetables",
      "prefill": {
        "contact": "",
        "email": "",
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment Success");
    Toast.show("Payment Success", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    /* Fluttertoast.showToast(
      msg: 'Payment to Order Vegetables Successful',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 10,
  
    ); */
  }

  void handlerErrorFailure() {
    print("Payment Error");
    Toast.show("Payment ERROR", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    /*Fluttertoast.showToast(
      msg: 'ERR IN PAYMENT',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 10,
    );*/
  }

  void handlerExternalWallet() {
    print("Payment — External Wallet");
    Toast.show("Payment — External Wallet", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    /*Fluttertoast.showToast(
      msg: 'Payment to Order Vegetables — External Wallet',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 10,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text('Pay Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "Payment amount (find on bill sent w/ order)"),
            ),
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    openCheckout();
                  },
                  child: Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white, fontFamily: 'SFPro'),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90.0)),
                ))
          ],
        ),
      ),
    );
  }
}

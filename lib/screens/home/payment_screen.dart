import 'package:flutter/material.dart';
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
      "key": "rzp_test_pj4fmot7QpGD1C",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Order Vegetables",
      "description": "Payment for order; ordered from Order Vegetables",
      "prefill": {
        "contact": "1122334450",
        "email": "aarav@hattangadi.com",
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
    Toast.show('Payment Successful', context);
  }

  void handlerErrorFailure() {
    print("Payment Error");
    Toast.show('Error in Payment', context);
  }

  void handlerExternalWallet() {
    print("Payment — External Wallet");
    Toast.show('Payment — External Wallet', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        title: Text('Pay Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "Payment amount (find on bill sent w/ order)"),
            ),
            SizedBox(
              height: 12.0,
            ),
            RaisedButton(
                child: Text('Pay Now'),
                onPressed: () {
                  openCheckout();
                })
          ],
        ),
      ),
    );
  }
}

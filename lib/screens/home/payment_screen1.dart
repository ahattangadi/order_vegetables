import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
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
                        'Pay Now',
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
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Column(children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 40,
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                        labelText: "Input amount to be paid",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9.]")),
                                      FilteringTextInputFormatter.deny(RegExp(
                                          "[a-zA-z #%&'()*+,-./:;<=>?@[]^_`{|}~]\$€¥₤£¢₢₡₠৳฿¤₣₴₰₵₪₲₳₯₱₨﷼₫円₹]")),
                                    ]),
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
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SFPro'),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(90.0)),
                                  ))
                            ]),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'paymentFailed.dart';
import 'paymentSuccess.dart';
import 'razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class Payment extends StatefulWidget {
  final double cartTotal;
  final String accountId;
  final String shopName;
  final String shopId;

  const Payment(
      {Key key,
      @required this.cartTotal,
      @required this.accountId,
      this.shopId,
      this.shopName})
      : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Razorpay _razorpay = Razorpay();
//  double cartTotal = 2000;
//  String accountId = 'acc_EqDkbQSjjSfnSt';
//  String shopName = 'AtoZ_Shop';
//  String shopId = '1337';
  var options;
  String keyId = 'keyId';
  String keyValue = 'KeySecret';

  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void capturePayment(PaymentSuccessResponse response) async {
    String apiUrl =
        'https://$keyId:$keyValue@api.razorpay.com/v1/payments/${response.paymentId}/capture';
    final http.Response response2 = await http.post(
      apiUrl,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<dynamic, dynamic>{
        "amount": widget.cartTotal,
        "currency": "INR",
      }),
    );
    if (response2.statusCode == 200) {
      log('Payment is captured');
    }
    transferPayment(response);
  }

  void transferPayment(PaymentSuccessResponse response) async {
    String apiUrl =
        'https://$keyId:$keyValue@api.razorpay.com/v1/payments/${response.paymentId}/transfers';
    final http.Response response2 = await http.post(
      apiUrl,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<dynamic, dynamic>{
        "transfers": [
          {
            "account": "${widget.accountId}",
            "amount": widget.cartTotal,
            "currency": "INR",
            "notes": {
              "name": '${widget.shopName}',
              "roll_no": "${widget.shopId}"
            },
            "linked_account_notes": ["roll_no"],
            "on_hold": false
          }
        ]
      }),
    );
    log('${response2.body}');
    if (response2.statusCode == 200) {
      log('Payment is transferred');
    }
  }

  Future<String> generateOrderId() async {
    String apiUrl = 'https://$keyId:$keyValue@api.razorpay.com/v1/orders';
    final http.Response response2 = await http.post(
      apiUrl,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(
          <dynamic, dynamic>{"amount": widget.cartTotal, "currency": "INR"}),
    );
    log('${response2.body}');
    var extractData = jsonDecode(response2.body);
    return extractData['id'];
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("payment has succedded");
    capturePayment(response);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
          response: response,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
          response: response,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    super.initState();
//    String orderId = await generateOrderId();
    options = {
      'key': '$keyId', // Enter the Key ID generated from the Dashboard

      'amount': '${widget.cartTotal}', //in the smallest currency sub-unit.
      'name': 'E-Grocery',
      'currency': "INR",
//       'order_id' : orderId,
      'theme.color': '#FF9333',
      'buttontext': "E-Grocery",
      'description': 'DevUP',
      'prefill': {
        'contact': '',
        'email': '',
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

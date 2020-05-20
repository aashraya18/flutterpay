import 'package:flutter/material.dart';
import 'package:flutterpay/main.dart';
import 'razorpay_flutter.dart';

class SuccessPage extends StatelessWidget {
  final PaymentSuccessResponse response;
  SuccessPage({
    @required this.response,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Success"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your payment is successful and the response is\n\n PaymentId: ${response.paymentId}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlutterPay(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

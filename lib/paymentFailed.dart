import 'package:flutter/material.dart';

import 'razorpay_flutter.dart';
import 'main.dart';

class FailedPage extends StatelessWidget {
  final PaymentFailureResponse response;
  FailedPage({
    @required this.response,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Failed"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your payment is Failed and the response is\n Code: ${response.code}\nMessage: ${response.message}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
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

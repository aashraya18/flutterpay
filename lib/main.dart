import 'package:flutter/material.dart';
import 'package:flutterpay/payment.dart';

void main() {
  runApp(MaterialApp(
    home: FlutterPay(),
  ));
}

class FlutterPay extends StatefulWidget {
  @override
  _FlutterPayState createState() => _FlutterPayState();
}

class _FlutterPayState extends State<FlutterPay> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cartTotal = 0;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff33A4FF),
          title: Text(
            'Razorpay',
          ),
        ),
        backgroundColor: Color(0xffF9E79F),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Amount',
                    hintText: '200'),
                onChanged: (String value) {
                  cartTotal = double.parse(value);
                },
              ),
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              color: Color(0xff33A4FF),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Payment(
                      cartTotal: cartTotal * 100,
                      shopName: 'a_z',
                      shopId: '1337',
                      accountId: 'acc_EqDkbQSjjSfnSt',
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            ),
          ],
        ));
  }
}

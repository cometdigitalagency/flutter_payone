import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_payone/constants.dart';
import 'package:flutter_payone/flutter_payone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _initStoreResponse = '';
  String _qrcodeValue = '';
  String _transactionValue = '';

  @override
  void initState() {
    super.initState();
    initState();
  }

  Future<void> initStore() async {
    String initStoreResponse;
    String mcid = "";
    String applicationId = "";
    String bankName = "";
    Country country = Country.lao;
    Province province = Province.vientiane;
    String subscribeKey = "";
    String terminalid = "";
    try {
      initStoreResponse = await FlutterPayone.initStore(mcid, province,
          subscribeKey, terminalid, country, bankName, applicationId);
    } on Exception catch (_) {
      initStoreResponse = "error";
    }
    setState(() {
      _initStoreResponse = initStoreResponse;
    });
  }

  Future<void> buildQrcode() async {
    String qrcodeResponse;
    int amount = 1;
    Currency currency = Currency.laoKip;
    String description = "";
    try {
      qrcodeResponse =
          await FlutterPayone.buildQrcode(amount, currency, description);
    } on Exception catch (_) {
      qrcodeResponse = "error";
    }
    setState(() {
      _qrcodeValue = qrcodeResponse;
    });
  }

  Future<void> startObserve() async {
    String transactionValue;
    try {
      transactionValue = await FlutterPayone.startObserve();
    } on Exception catch (_) {
      transactionValue = "error";
    }
    setState(() {
      _transactionValue = transactionValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('initialize store with response : $_initStoreResponse\n'),
              FlatButton(
                  onPressed: () {
                    buildQrcode();
                  },
                  child: Text("build string of qrcode")),
              Text('qrcode value is : $_qrcodeValue\n'),
              FlatButton(
                  onPressed: () {
                    startObserve();
                  },
                  child: Text("build string of qrcode")),
              Text('transaction detail is : $_transactionValue\n'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:comet_payone/constants.dart';
import 'package:comet_payone/comet_payone.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _initStoreResponse = '';
  String _qrcodeValue = '';
  String _transactionValue = '';

  Future<void> initStore() async {
    String initStoreResponse;

    String mcid = "mch6066c3a96b789";
    String applicationId = "ONEPAY";
    String bankName = "BCEL";
    Country country = Country.lao;
    Province province = Province.vientiane;
    String subscribeKey = "sub-c-91489692-fa26-11e9-be22-ea7c5aada356";
    String terminalid = "12345678";
    try {
      initStoreResponse = await CometPayone.initStore(mcid, province,
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
          await CometPayone.buildQrcode(amount, currency, description);
    } on Exception catch (_) {
      qrcodeResponse = _.toString();
    }
    setState(() {
      _qrcodeValue = qrcodeResponse;
    });
  }

  Future<void> startObserve() async {
    String transactionValue;
    try {
      transactionValue = await CometPayone.startObserve();
    } on Exception catch (_) {
      transactionValue = "error";
    }
    setState(() {
      _transactionValue = transactionValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      initStore();
                    },
                    child: Text("init store")),
                ElevatedButton(
                    onPressed: () {
                      buildQrcode();
                    },
                    child: Text("build string of qrcode")),
                ElevatedButton(
                    onPressed: () {
                      startObserve();
                    },
                    child: Text("start observe")),
                Text(_initStoreResponse),
                QrImage(
                  data: _qrcodeValue,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                Text(_transactionValue)
              ],
            )
          ],
        ),
      ),
    );
  }
}

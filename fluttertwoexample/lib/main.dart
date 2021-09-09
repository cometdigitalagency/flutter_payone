import 'package:flutter/material.dart';
import 'package:flutter_payone/constants.dart';
import 'package:flutter_payone/flutter_payone.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      qrcodeResponse = _.toString();
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

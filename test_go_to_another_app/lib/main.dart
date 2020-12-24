import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payone/constants.dart';
import 'package:flutter_payone/flutter_payone.dart';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Coflutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initstore() async {
    FlutterPayone.initStore(
        "mch5e436d803c35d",
        Province.vientiane,
        "sub-c-91489692-fa26-11e9-be22-ea7c5aada356",
        "123456",
        Country.lao,
        "BCEL",
        "ONEPAY");
  }

  buildqrcode({@required int amountOfMoney}) async {
    String response = "";

    try {
      // final result = await platform.invokeMethod('initStore', stringParams);
      final result = await FlutterPayone.buildQrcode(amountOfMoney,
          Currency.laoKip, "Lao");
      response = result.toString();
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  startObserve() async {
    String response = "";
    try {
      final result = await FlutterPayone.startObserve();
      response = result.toString();
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Show Material Dialog'),
              onPressed: _showMaterialDialog,
            ),
            RaisedButton(
              child: Text('open facebook'),
              onPressed: () async {
                const url =
                    'fb://profile/408834569303957';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            RaisedButton(
              child: Text('open bcel'),
              onPressed: () async {
                initstore();
                var generate = await buildqrcode(amountOfMoney: 1000);
                print(generate);
                var url = 'onepay://qr://00020101021133380004BCEL0106ONEPAY0216mch5e436d803c35d520441115303418540410005802LA6003VTE62720121comet1608801339810192053633f32dd0-ebc4-4385-9427-35478df8facd0803Lao6304B6BB';
                await launch(url);
              },
            ),
            RaisedButton(
              child: Text('Show Cupertino Dialog'),
              onPressed: () async {
                _showCupertinoDialog();
                await Future.delayed(Duration(milliseconds: 1500), () {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Material Dialog"),
              content: new Text("Hey! I'm Coflutter!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Cupertino Dialog"),
              content: new Text("Hey! I'm Coflutter!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

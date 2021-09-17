import 'package:comet_payone/constants.dart';
import 'package:comet_payone/comet_payone.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_payone');

  TestWidgetsFlutterBinding.ensureInitialized();
  var observeRes = {
    "id": 15152117,
    "mcid": "mch5e436d803c35d",
    "tid": null,
    "iid": "123",
    "uuid": "123",
    "txtime": "17/09/2021 10:41:12",
    "amount": 1,
    "ccy": "LAK",
    "merchantname": "LAO TAXI SERVICES SOLE",
    "name": "Xokthilat Oudomdy",
    "phone": "57400033",
    "itemname": null,
    "description": "Lao Taxi Service",
    "ticket": "JAKHV43RA7JI",
    "fccref": "20210917102987"
  };
  group("payone test success", () {
    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == "buildqrcode") {
          return "00020101021133380004BCEL0106ONEPAY0216mch6066c3a96b789520441115303418540115802LA6003VTE62850121comet163124667466530805360e14aa5b-41e4-4ba2-8151-222449ab870d0708123456780804test6304744e";
        } else if (methodCall.method == "initStore") {
          return "initialized store";
        } else if (methodCall.method == "observe") {
          return observeRes;
        }
        return '42';
      });
    });

    tearDown(() {
      channel.setMockMethodCallHandler(null);
    });

    test('test init store lao vte', () async {
      String mcid = "mch6066c3a96b789";
      String applicationId = "ONEPAY";
      String bankName = "BCEL";
      Country country = Country.lao;
      Province province = Province.vientiane;
      String subscribeKey = "sub-c-91489692-fa26-11e9-be22-ea7c5aada356";
      String terminalid = "12345678";
      expect(
          await CometPayone.initStore(mcid, province, subscribeKey,
              terminalid, country, bankName, applicationId),
          'initialized store');
    });
    test('test build qrcode', () async {
      expect(await CometPayone.buildQrcode(1, Currency.laoKip, "test"),
          "00020101021133380004BCEL0106ONEPAY0216mch6066c3a96b789520441115303418540115802LA6003VTE62850121comet163124667466530805360e14aa5b-41e4-4ba2-8151-222449ab870d0708123456780804test6304744e");
    });

    test('test observe', () async {
      expect(await CometPayone.startObserve(), observeRes.toString());
    });
  });
  group("payone test failed", () {
    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == "buildqrcode") {
          return throw PlatformException(code: "error");
        } else if (methodCall.method == "initStore") {
          return throw PlatformException(code: "error");
        } else if (methodCall.method == "observe") {
          return throw PlatformException(code: "error");
        }
        return '42';
      });
    });

    tearDown(() {
      channel.setMockMethodCallHandler(null);
    });

    test('test init store lao vte', () async {
      String mcid = "mch6066c3a96b789";
      String applicationId = "ONEPAY";
      String bankName = "BCEL";
      Country country = Country.lao;
      Province province = Province.vientiane;
      String subscribeKey = "sub-c-91489692-fa26-11e9-be22-ea7c5aada356";
      String terminalid = "12345678";
      final call = CometPayone.initStore;
      expect(
          () => call(mcid, province, subscribeKey, terminalid, country,
              bankName, applicationId),
          throwsA(TypeMatcher<PlatformException>()));
    });
    test('test build qrcode', () async {
      final call = CometPayone.buildQrcode;
      expect(() => call(1, Currency.laoKip, "test"),
          throwsA(TypeMatcher<PlatformException>()));
    });

    test('test observe', () async {
      final call = CometPayone.startObserve;
      expect(() => call(), throwsA(TypeMatcher<PlatformException>()));
    });
  });
}

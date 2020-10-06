import 'dart:async';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter_payone/constants.dart';

class FlutterPayone {
  static const MethodChannel _channel = const MethodChannel('flutter_payone');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> initStore(
      String mcid,
      Province province,
      String subscribeKey,
      String terminalid,
      Country country,
      String bankName,
      String applicationId) async {
    String response = "";
    String countryCode = PayOneDataHelper.getCountryCode(country);
    String provinceCode = PayOneDataHelper.getProvinceCode(province);

    var storeData = <String, dynamic>{
      'mcid': mcid,
      'province': provinceCode,
      'subscribeKey': subscribeKey,
      'terminalid': terminalid,
      'country': countryCode,
      'iin': bankName,
      'applicationid': applicationId
    };

    try {
      final result = await _channel.invokeMethod('initStore', storeData);
      response = result.toString();
      return response;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  static Future<String> buildQrcode(
      int amount, Currency currency, String description) async {
    String response = "";
    String currencyCode = PayOneDataHelper.getCurrencyCode(currency);
    var stringParams = <String, dynamic>{
      'amount': amount.toString(),
      'currency': currencyCode,
      'invoiceid': '#comet' + DateTime.now().microsecondsSinceEpoch.toString(),
      'description': description
    };

    try {
      final result = await _channel.invokeMethod('buildqrcode', stringParams);
      response = result.toString();
      return response;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  static Future<String> startObserve() async {
    try {
      final result = await _channel.invokeMethod('observe');
      String response = result.toString();
      return response;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}

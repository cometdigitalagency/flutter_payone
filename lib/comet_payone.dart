import 'dart:async';
import 'package:comet_payone/constants.dart';
import 'package:flutter/services.dart';

class CometPayone {
  static const MethodChannel _channel = const MethodChannel('flutter_payone');

  /// ເລີ່ມຕົ້ນສະໝັກຮ້ານຂອງທ່ານ ເຊີ່ງ mcid ແລະ subscribeKey ຈະໄດ້ມາຈາກທະນາຄານການຄ້າຕ່າງປະເທດລາວ ສ່ວນ terminalid ແມ່ນໃສ່ຕາມໃຈ
  static Future<String> initStore(
      String mcid,
      Province province,
      String subscribeKey,
      String terminalid,
      Country country,
      String? bankName,
      String? applicationId) async {
    String response = "";
    String countryCode = PayOneDataHelper.getCountryCode(country);
    String provinceCode = PayOneDataHelper.getProvinceCode(province);
    if (bankName == null) bankName = "BCEL";
    if (applicationId == null) applicationId = "ONEPAY";
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
      throw e;
    }
  }

  /// amount ແມ່ນຈໍານວນເງິນແລະສະກຸນເງິນແມ່ນ ກີບ ແລະ ສາມາດໃສ່ຄໍາອະທິບາຍ description ໄດ້ເລີຍ ໂດຍຈະໄດ້ຮັບເປັນ string ເພື່ອເອົາໄປສ້າງ qrcode
  static Future<String> buildQrcode(
      int amount, Currency currency, String description) async {
    String response = "";
    String currencyCode = PayOneDataHelper.getCurrencyCode(currency);
    var stringParams = <String, dynamic>{
      'amount': amount.toString(),
      'currency': currencyCode,
      'invoiceid': 'comet' + DateTime.now().microsecondsSinceEpoch.toString(),
      'description': description
    };

    try {
      final result = await _channel.invokeMethod('buildqrcode', stringParams);
      response = result.toString();
      return response;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  /// ແລະສາມາດເລີ່ມຕິດຕາມທຸລະກໍາໄດ້ເລີຍ ໂດຍມັນຈະຕອບໂຕ້ກັບຄືນດ້ວຍຂໍ້ມູນທຸລະກໍາ ເຊັ່ນ ຊື່ຄົນຈ່າຍ,ຈໍານວນເງິນ etc...
  static Future<String> startObserve() async {
    try {
      final result = await _channel.invokeMethod('observe');
      String response = result.toString();
      return response;
    } on PlatformException catch (e) {
      throw e;
    }
  }
}

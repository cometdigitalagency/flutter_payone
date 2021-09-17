# comet_payone

[![pub package](https://img.shields.io/pub/v/comet_payone.svg)](https://pub.dartlang.org/packages/comet_payone)
[![codecov](https://codecov.io/gh/cometdigitalagency/flutter_payone/branch/master/graph/badge.svg?token=OB2RZWR16Y)](https://codecov.io/gh/cometdigitalagency/flutter_payone)

Comet payone for [Flutter](https://flutter.io) package to connect to bcel, developed by comet.

The package will generate qrcode for payment and tracking transaction status.

## Installation

add the following code to your `pubspec.yaml` :

```yaml
dependencies:
  comet_payone: ^2.0.0
```

## Usage

import the package

```dart
import 'package:flutter_payone/constants.dart';
import 'package:flutter_payone/flutter_payone.dart';
```

Register your shop with mcid and subcribeKey which will be granted by BCEL

```dart
Future<String> initStore() async {
    String mcid = "mch6066c3a96b789";
    String applicationId = "ONEPAY";
    String bankName = "BCEL";
    Country country = Country.lao;
    Province province = Province.vientiane;
    String subscribeKey = "sub-c-91489692-fa26-11e9-be22-ea7c5aada356";
    String terminalid = "12345678";

    return await FlutterPayone.initStore(mcid, province,
          subscribeKey, terminalid, country, bankName, applicationId);
  }
```

Generate QR Code, example: amount = 1 and LAK currency. You also can add a description to the QR Code which will accept string value.

```dart
Future<String> buildQrcode() async {
    int amount = 1;
    Currency currency = Currency.laoKip;
    String description = "";
    return  await FlutterPayone.buildQrcode(amount, currency, description);
  }
```

Now you can start tracking transaction, expect transaction response are customer name, paid amount, etc.

```dart
  Future<String> startObserve() async {
    return await FlutterPayone.startObserve();
  }
```

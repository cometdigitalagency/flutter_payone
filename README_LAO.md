# comet_payone
[![pub package](https://img.shields.io/pub/v/comet_payone.svg)](https://pub.dartlang.org/packages/comet_payone) 
[![codecov](https://codecov.io/gh/cometdigitalagency/flutter_payone/branch/master/graph/badge.svg?token=OB2RZWR16Y)](https://codecov.io/gh/cometdigitalagency/flutter_payone)

Comet payone ສໍາຫຼັບ  [Flutter](https://flutter.io) ແພັກເກັດເຊື່ອມຕໍ່ bcel ພັດທະນາໂດຍທີມ comet.

ເພັກເກັດທີ່ຈະຊ່ວຍໃຫ້ທ່ານ ສ້າງ qrcode ສໍາຫຼັບຈ່າຍເງິນ ແລະ ຕິດຕາມວ່າ ທຸລະກໍາຂອງທ່ານສໍາເລັດຫຼືຍັງ

## ຕິດຕັ້ງ
ເພີ່ມ code ນີ້ໃສ່ `pubspec.yaml` :

```yaml
dependencies:
  comet_payone: ^1.1.0
```

## ນໍາໃຊ້

import ດ້ວຍ code ລຸ່ມນີ້

```dart
import 'package:flutter_payone/constants.dart';
import 'package:flutter_payone/flutter_payone.dart';
```

ເລີ່ມຕົ້ນສະໝັກຮ້ານຂອງທ່ານ ເຊີ່ງ mcid ແລະ subscribeKey ຈະໄດ້ມາຈາກທະນາຄານການຄ້າຕ່າງປະເທດລາວ

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
ສ້າງ QR code ຈາກຮ້ານທີ່ທ່ານຫາກໍສ້າງກີ້ນີ້ ໂດຍ amount ແມ່ນຈໍານວນເງິນໃນຕົວຢ່າງເຮົາຈະໃສ່ 1 ກີບ ແລະສະກຸນເງິນແມ່ນ ກີບ ແລະ ສາມາດໃສ່ຄໍາອະທິບາຍ description ໄດ້ເລີຍ ໂດຍຈະໄດ້ຮັບເປັນ string ເພື່ອເອົາໄປສ້າງ qrcode
```dart
Future<String> buildQrcode() async {
    int amount = 1;
    Currency currency = Currency.laoKip;
    String description = "";
    return  await FlutterPayone.buildQrcode(amount, currency, description);
  }
```

ແລະສາມາດເລີ່ມຕິດຕາມທຸລະກໍາໄດ້ເລີຍ ໂດຍມັນຈະຕອບໂຕ້ກັບຄືນດ້ວຍຂໍ້ມູນທຸລະກໍາ ເຊັ່ນ ຊື່ຄົນຈ່າຍ,ຈໍານວນເງິນ etc...

```dart
  Future<String> startObserve() async {
    return await FlutterPayone.startObserve();
  }
```

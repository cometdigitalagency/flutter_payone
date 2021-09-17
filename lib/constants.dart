enum Country { lao }
enum Province { vientiane }

enum Currency { laoKip }

class PayOneDataHelper {
  static String getCountryCode(Country name) {
    switch (name) {
      case Country.lao:
        return "LA";
    }
  }

  static String getProvinceCode(Province name) {
    switch (name) {
      case Province.vientiane:
        return "VTE";
    }
  }

  static String getCurrencyCode(Currency name) {
    switch (name) {
      case Currency.laoKip:
        return "418";
    }
  }
}

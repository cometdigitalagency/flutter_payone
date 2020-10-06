enum Country { lao, thai }
enum Province { luangphabang, vientiane }

enum Currency { laoKip, thaiBaht }

class PayOneDataHelper {
  static String getCountryCode(Country name) {
    switch (name) {
      case Country.lao:
        return "LA";
      case Country.thai:
        return "TH";
    }
    return "LA";
  }

  static String getProvinceCode(Province name) {
    switch (name) {
      case Province.vientiane:
        return "VTE";
      case Province.luangphabang:
        return "LPB";
    }
    return "VTE";
  }

  static String getCurrencyCode(Currency name) {
    switch (name) {
      case Currency.laoKip:
        return "418";
      case Currency.thaiBaht:
        return "123";
    }
    return "418";
  }
}

import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatter = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    );

    return formatter.format(number);
  }
}

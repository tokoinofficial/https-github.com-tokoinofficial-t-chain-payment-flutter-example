import 'package:currency_formatter/currency_formatter.dart';

class Formatter {
  static final CurrencyFormatterSettings _vnSettings =
      CurrencyFormatterSettings(
    symbol: 'VND',
    symbolSide: SymbolSide.right,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  static String format({required double money}) {
    return CurrencyFormatter.format(money, _vnSettings);
  }
}

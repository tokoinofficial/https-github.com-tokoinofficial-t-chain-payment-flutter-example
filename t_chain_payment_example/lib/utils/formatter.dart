import 'package:currency_formatter/currency_formatter.dart';

class Formatter {
  static final CurrencyFormatterSettings _vnSettings =
      CurrencyFormatterSettings(
    symbol: 'IDR',
    symbolSide: SymbolSide.left,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  static String format({required double money}) {
    return CurrencyFormatter.format(money, _vnSettings);
  }
}

import 'package:forex_conversion/forex_conversion.dart';

class ExchangeService {
  static final ExchangeService _instance = ExchangeService._();
  static ExchangeService get instance => _instance;

  ExchangeService._();

  static const vnd = 'VND';
  static const usd = 'USD';

  final fx = Forex();

  Future<double> convert({
    required String from,
    required String to,
    required double amount,
  }) async {
    return await fx.getCurrencyConverted(from, to, amount);
  }
}

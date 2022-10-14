import 'package:t_chain_payment_example/src/payment/exchange_service.dart';
import 'package:t_chain_payment_example/src/payment/payment_base.dart';
import 'package:t_chain_payment_sdk/t_chain_payment_sdk.dart';

class TChainPaymentImpl extends PaymentBase {
  @override
  init() {
    TChainPaymentSDK.instance.init(
      merchantID:
          '0xc3f2f0deaf2a9e4d20aae37e8802b1efef589d1a9e45e89ce1a2e179516df071',
      bundleID: 'com.tokoin.tchainpayment.example',
      delegate: _handleResult,
    );
  }

  void _handleResult(TChainPaymentResult result) {
    if (result.status == TChainPaymentStatus.success) {
      onSuccess?.call();
    } else {
      onError?.call(result.errorMessage ?? 'Unknown Error');
    }
  }

  @override
  pay({required String orderID, required num amount}) async {
    final newAmount = await ExchangeService.instance.convert(
      from: ExchangeService.vnd,
      to: ExchangeService.usd,
      amount: amount.toDouble(),
    );

    final TChainPaymentResult result = await TChainPaymentSDK.instance.deposit(
      orderID: orderID,
      amount: newAmount,
    );

    _handleResult(result);
  }
}

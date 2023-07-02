import 'package:t_chain_payment_example/src/payment/payment_base.dart';
import 'package:t_chain_payment_example/utils/constants.dart';
import 'package:t_chain_payment_sdk/t_chain_payment_sdk.dart';

class TChainPaymentImpl extends PaymentBase {
  @override
  init() {
    TChainPaymentSDK.instance.init(
      apiKey: Constants.apiKey,
      bundleID: Constants.bundleID,
      delegate: _handleResult,
      isTestnet: true,
    );
  }

  void _handleResult(TChainPaymentResult result) {
    if (result.status == TChainPaymentStatus.success) {
      onSuccess?.call();
      return;
    }

    if (result.status == TChainPaymentStatus.cancelled) {
      onCancelled?.call();
      return;
    }

    if (result.status == TChainPaymentStatus.error ||
        result.status == TChainPaymentStatus.failed) {
      onError?.call(result.errorMessage ?? 'Unknown Error');
      return;
    }
  }

  @override
  pay({required String orderID, required num amount}) async {
    final TChainPaymentResult result = await TChainPaymentSDK.instance.deposit(
      orderID: orderID,
      amount: amount.toDouble(),
      currency: TChainPaymentCurrency.idr,
    );

    _handleResult(result);
  }
}

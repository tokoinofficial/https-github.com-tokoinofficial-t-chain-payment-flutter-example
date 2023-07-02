import 'package:flutter/widgets.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:t_chain_payment_example/src/payment/payment_base.dart';

class MomoPaymentImpl extends PaymentBase {
  late MomoVn _momoPay;

  @override
  init() {
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    onSuccess?.call();
  }

  void _handlePaymentError(PaymentResponse response) {
    onError?.call(response.message ?? 'Unknown Error');
  }

  @override
  void pay({required String orderID, required num amount}) {
    MomoPaymentInfo options = MomoPaymentInfo(
      merchantName: "TTNC&TVKT",
      appScheme: "MOMOUMGQ111111",
      merchantCode: 'MOMOUMGQ111111',
      partnerCode: 'MOMOUMGQ111111',
      amount: amount.toInt(),
      orderId: orderID,
      orderLabel: orderID,
      merchantNameLabel: "MOMOUMGQ111111",
      fee: 10,
      description: '111',
      username: '01234567890',
      partner: 'merchant',
      extra: "",
      isTestMode: true,
    );

    try {
      _momoPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

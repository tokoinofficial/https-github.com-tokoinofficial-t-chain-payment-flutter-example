import 'package:flutter/widgets.dart';

import 'package:t_chain_payment_example/src/payment/momo_payment_impl.dart';
import 'package:t_chain_payment_example/src/payment/t_chain_payment_impl.dart';

enum PaymentType { cashOnDelivery, momo, tChainPayment }

extension PaymentTypeExt on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentType.momo:
        return 'Momo';
      case PaymentType.tChainPayment:
        return 'T-Chain Payment';
    }
  }
}

class PaymentController with ChangeNotifier {
  late MomoPaymentImpl _momoPayment;
  late TChainPaymentImpl _tChainPayment;

  PaymentController() {
    _momoPayment = MomoPaymentImpl();
    _momoPayment.init();

    _tChainPayment = TChainPaymentImpl();
    _tChainPayment.init();
  }

  PaymentType _paymentType = PaymentType.cashOnDelivery;
  PaymentType get paymentType => _paymentType;
  set paymentType(PaymentType type) {
    if (type == _paymentType) return;

    _paymentType = type;

    notifyListeners();
  }

  Future pay({
    required String orderID,
    required int amount,
    required Function() onSuccess,
    required Function(String) onError,
    required Function() onCancelled,
  }) async {
    switch (_paymentType) {
      case PaymentType.cashOnDelivery:
        onSuccess.call();
        return;

      case PaymentType.momo:
        _momoPayment.onSuccess = onSuccess;
        _momoPayment.onError = onError;
        _momoPayment.onCancelled = onCancelled;
        _momoPayment.pay(orderID: orderID, amount: amount);
        return;

      case PaymentType.tChainPayment:
        _tChainPayment.onSuccess = onSuccess;
        _tChainPayment.onError = onError;
        _tChainPayment.onCancelled = onCancelled;
        _tChainPayment.pay(orderID: orderID, amount: amount);
        return;
    }
  }
}

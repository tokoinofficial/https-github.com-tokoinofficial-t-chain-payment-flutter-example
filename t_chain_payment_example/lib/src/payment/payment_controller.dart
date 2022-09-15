import 'package:flutter/widgets.dart';
import 'package:t_chain_payment_example/src/payment/momo_payment_impl.dart';

enum PaymentType { cashOnDelivery, momo }

extension PaymentTypeExt on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentType.momo:
        return 'Momo';
    }
  }
}

class PaymentController with ChangeNotifier {
  late MomoPaymentImpl _momoPayment;

  PaymentController() {
    _momoPayment = MomoPaymentImpl();
    _momoPayment.init();
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
  }) async {
    if (_paymentType == PaymentType.cashOnDelivery) {
      onSuccess.call();
      return;
    }

    if (_paymentType == PaymentType.momo) {
      _momoPayment.onSuccess = onSuccess;
      _momoPayment.onError = onError;
      _momoPayment.pay(orderID: orderID, amount: amount);
      return;
    }
  }
}

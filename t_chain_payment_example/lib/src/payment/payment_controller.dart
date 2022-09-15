import 'package:flutter/widgets.dart';

enum PaymentType { cashOnDelivery }

extension PaymentTypeExt on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }
}

class PaymentController with ChangeNotifier {
  PaymentType _paymentType = PaymentType.cashOnDelivery;
  PaymentType get paymentType => _paymentType;
  set paymentType(PaymentType type) {
    if (type == _paymentType) return;

    _paymentType = type;

    notifyListeners();
  }

  Future pay({
    required Function() onSuccess,
    required Function() onError,
  }) async {
    if (_paymentType == PaymentType.cashOnDelivery) {
      onSuccess.call();
      return;
    }

    // T-Chain
    onSuccess.call();
  }
}

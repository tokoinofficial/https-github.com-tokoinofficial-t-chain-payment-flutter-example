abstract class PaymentBase {
  init();

  Function()? onSuccess;
  Function(String)? onError;

  pay({required String orderID, required int amount});
}

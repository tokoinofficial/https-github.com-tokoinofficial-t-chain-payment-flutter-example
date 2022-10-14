abstract class PaymentBase {
  init();

  Function()? onSuccess;
  Function()? onCancelled;
  Function(String)? onError;

  pay({required String orderID, required num amount});
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_chain_payment_example/src/cart/cart_controller.dart';
import 'package:t_chain_payment_example/src/payment/payment_controller.dart';
import 'package:t_chain_payment_example/src/products/product_list_view.dart';
import 'package:t_chain_payment_example/src/widgets/bottom_bar.dart';
import 'package:t_chain_payment_example/utils/constants.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    Key? key,
    required this.orderID,
  }) : super(key: key);

  static const routeName = '/payment';

  final String orderID;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? message;
  late CartController _cartController;
  late PaymentController _paymentController;

  @override
  void initState() {
    super.initState();

    _cartController = context.read<CartController>();
    _paymentController = context.read<PaymentController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onPay();
    });
  }

  _onPay() {
    context.read<PaymentController>().pay(
          orderID: widget.orderID,
          amount: _cartController.totalPrice.toInt(),
          onSuccess: () {
            _cartController.removeAll();
            setState(() {
              message = "Thanks\nfor your order";
            });
          },
          onCancelled: () {
            setState(() {
              message = "Cancelled";
            });
          },
          onError: (errorMessage) {
            setState(() {
              message = errorMessage;
            });
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return _buildMessage(message: message);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Constants.hPadding),
            child: Column(
              children: [
                Text('ORDER ID: ${widget.orderID}'),
                const SizedBox(height: 24),
                const Text(
                  'Amount',
                ),
                const SizedBox(height: 8),
                Text(
                  context.read<CartController>().totalPrice.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomBar(
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _onPay,
          child: Text('Continue with ${_paymentController.paymentType.name}'),
        ),
      ),
    );
  }

  Widget _buildMessage({required message}) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil(
                  (route) => route.settings.name == ProductListView.routeName);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

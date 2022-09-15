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
  bool isSuccess = false;
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
              isSuccess = true;
            });
          },
          onError: (errorMessage) {},
        );
  }

  @override
  Widget build(BuildContext context) {
    if (isSuccess) {
      return _buildThanks();
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

  Widget _buildThanks() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Thanks\nfor your order',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
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

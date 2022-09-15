import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_chain_payment_example/src/cart/cart_controller.dart';
import 'package:t_chain_payment_example/src/payment/payment_controller.dart';
import 'package:t_chain_payment_example/src/payment/payment_view.dart';
import 'package:t_chain_payment_example/src/widgets/bottom_bar.dart';
import 'package:t_chain_payment_example/utils/constants.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildCart(),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildCart() {
    return Consumer<CartController>(
      builder: (BuildContext context, cart, Widget? child) {
        if (cart.items.isEmpty) {
          return const Center(
            child: Text(
              'Empty',
            ),
          );
        }
        return ListView.builder(
          restorationId: 'sampleItemListView',
          itemCount: cart.items.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == cart.items.length) {
              return _buildDeliveryOption();
            }

            if (index == cart.items.length + 1) {
              return _buildPaymentMethod();
            }

            final item = cart.items[index];
            return ListTile(
              title: Text(item.product.name),
              subtitle: Text('\$${item.product.price}'),
              leading: CircleAvatar(
                foregroundImage: AssetImage(item.product.image),
              ),
              trailing: Text('x ${item.amount}'),
            );
          },
        );
      },
    );
  }

  Widget _buildDeliveryOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.hPadding,
        vertical: 8,
      ),
      child: Row(
        children: const [
          Text(
            'Delivery option',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              'Standard Delivery',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.hPadding,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 80,
            child: Consumer<PaymentController>(
              builder: (context, paymentController, child) {
                return ListView.builder(
                  itemCount: PaymentType.values.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    final paymentType = PaymentType.values[index];
                    final isSelected =
                        paymentType == paymentController.paymentType;

                    return Card(
                      color: isSelected ? Colors.blue.shade100 : null,
                      child: InkWell(
                        onTap: () =>
                            paymentController.paymentType = paymentType,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(paymentType.name),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomBar(
      child: SafeArea(
        child: Consumer<CartController>(
          builder: (BuildContext context, cart, Widget? child) {
            return Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total'),
                      Text(
                        '\$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            Navigator.of(context)
                                .restorablePushNamed(PaymentView.routeName);
                          },
                    child: const Text('PLACE ORDER'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:t_chain_payment_example/src/widgets/shopping_cart_badge.dart';
import 'package:t_chain_payment_example/src/products/products_controller.dart';

import 'product_details_view.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toy Collection'),
        actions: const [ShoppingCartBadge()],
      ),
      body: Consumer<ProductsController>(
        builder: (BuildContext context, controller, Widget? child) {
          return ListView.builder(
            restorationId: 'sampleItemListView',
            itemCount: controller.items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = controller.items[index];

              return ListTile(
                  title: Text(item.name),
                  subtitle: Text('\$${item.price}'),
                  leading: CircleAvatar(
                    foregroundImage: AssetImage(item.image),
                  ),
                  onTap: () {
                    Navigator.restorablePushNamed(
                      context,
                      ProductDetailsView.routeName,
                      arguments: item.id,
                    );
                  });
            },
          );
        },
      ),
    );
  }
}

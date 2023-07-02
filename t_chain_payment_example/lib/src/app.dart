import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:t_chain_payment_example/src/cart/cart_controller.dart';
import 'package:t_chain_payment_example/src/cart/cart_view.dart';
import 'package:t_chain_payment_example/src/checkout/checkout_view.dart';
import 'package:t_chain_payment_example/src/payment/payment_controller.dart';
import 'package:t_chain_payment_example/src/payment/payment_view.dart';
import 'package:t_chain_payment_example/src/products/products_controller.dart';
import 'package:t_chain_payment_example/src/products/products_service.dart';
import 'package:t_chain_payment_example/src/products/product_details_view.dart';
import 'package:t_chain_payment_example/src/products/product_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              ProductsController(ProductsService())..loadData(),
        ),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => PaymentController()),
      ],
      child: MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: ThemeData(),
        onGenerateRoute: (RouteSettings routeSettings) {
          Widget screen;
          switch (routeSettings.name) {
            case PaymentView.routeName:
              final orderID = routeSettings.arguments as String?;
              if (orderID == null) {
                throw Exception('order ID is missing');
              }

              screen = PaymentView(orderID: orderID);
              return MaterialPageRoute<void>(
                settings: routeSettings,
                fullscreenDialog: true,
                builder: (context) => screen,
              );

            case CheckoutView.routeName:
              screen = const CheckoutView();
              break;
            case CartView.routeName:
              screen = const CartView();
              break;
            case ProductDetailsView.routeName:
              final productID = routeSettings.arguments as String?;
              if (productID == null) {
                throw Exception('product ID is missing');
              }
              screen = ProductDetailsView(productID: productID);
              break;
            case ProductListView.routeName:
            default:
              screen = const ProductListView();
          }

          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (context) => screen,
          );
        },
      ),
    );
  }
}

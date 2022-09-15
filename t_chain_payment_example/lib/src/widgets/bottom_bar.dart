import 'package:flutter/material.dart';
import 'package:t_chain_payment_example/utils/constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.hPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

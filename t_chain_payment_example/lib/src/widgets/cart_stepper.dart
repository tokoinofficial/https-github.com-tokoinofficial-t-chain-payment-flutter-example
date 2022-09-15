import 'package:flutter/material.dart';

class CartStepper extends StatelessWidget {
  const CartStepper({
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  final int value;
  final Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => onChanged?.call(value - 1),
          icon: const Icon(Icons.remove),
        ),
        Text('$value'),
        IconButton(
          onPressed: () => onChanged?.call(value + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

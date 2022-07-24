import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CardCard extends StatelessWidget {
  // const CartItem({Key? key}) : super(key: key);

  CardCard(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.title});

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  double roundDouble(double value, double places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Remove item?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Yes'))
            ],
          ),
        );
        return Future.value(true);
      },
      onDismissed: (direction) {
        return Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(child: Text('\$$price')))),
            title: Text(title),
            subtitle: Text('Total: \$ ${roundDouble(price * quantity, 2)}',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Text(
              '${quantity.toString()} x',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

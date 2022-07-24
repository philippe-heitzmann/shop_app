import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/cart_card.dart';
import '../providers/orders.dart';
import '../screens/orders_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  Future selectOrders(BuildContext ctx) {
    return Navigator.of(ctx).pushNamed(OrdersScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Shopping Cart')),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clearCart();
                      selectOrders(context);
                    },
                    child: Text('PLACE ORDER'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) => CardCard(
                    id: cart.items.values.toList()[index].id,
                    productId: cart.items.keys.toList()[index],
                    price: cart.items.values.toList()[index].price,
                    quantity: cart.items.values.toList()[index].quantity,
                    title: cart.items.values.toList()[index].title)),
          )
        ],
      ),
    );
  }
}

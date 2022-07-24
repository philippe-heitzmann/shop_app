import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_products_screen.dart';

import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  // void tapHandler() {}

  Widget builderListTile(IconData icon, String text, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Orders page'),
        ),
        const SizedBox(
          height: 10,
        ),
        builderListTile(Icons.shopping_cart, 'Shop', () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        builderListTile(Icons.shopping_cart_checkout, 'Cart', () {
          Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
        }),
        builderListTile(Icons.checklist_outlined, 'Orders', () {
          Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
        }),
        builderListTile(Icons.edit, 'Manage Products', () {
          Navigator.of(context)
              .pushReplacementNamed(UserProductsScreen.routeName);
        }),
      ],
    ));
  }
}

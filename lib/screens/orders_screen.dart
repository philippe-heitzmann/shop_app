import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_card.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your orders'),
        ),
        drawer: const MainDrawer(),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) {
            return OrderCard(
              order: orderData.orders[index],
            );
          },
        ) //Container(child: Text('Your orders')),
        );
  }
}

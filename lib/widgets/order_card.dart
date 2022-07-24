import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderCard extends StatefulWidget {
  final OrderItem order;

  OrderCard({required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  var expand = false;

  void expandTile() {
    setState(() {
      expand = !expand;
    });
    if (expand) {
      print('Expand widget!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.datetime),
            style: TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(
            icon: Icon(expand ? Icons.expand_less : Icons.expand_more),
            onPressed: expandTile,
          ),
        ),
        if (expand)
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 100, 100.0),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order.products[index].title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.order.products[index].quantity} x \$${widget.order.products[index].price}',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  );
                },
              )),
      ]),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.datetime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        Uri.https('shop-app-24bba-default-rtdb.firebaseio.com', '/orders.json');
    try {
      final response = await http.get(url);
      // print('Response: ');
      // print(response);
      final extractedData = json.decode(response.body);
      // print(extractedData);
      if (extractedData != null) {
        // print('Length products: ${extractedData.length}');
        final List<OrderItem> loadedOrders = [];
        extractedData.forEach((orderId, orderData) {
          var fetchedProducts = orderData['products'];
          loadedOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            products: fetchedProducts.map<CartItem>((product) {
              return CartItem(
                  id: product['id'],
                  title: product['title'],
                  price: product['price'],
                  quantity: product['quantity']);
            }).toList(),
            datetime: DateTime.parse(orderData['datetime']),
          ));
        });
        _orders = loadedOrders.reversed.toList();
        notifyListeners();
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        Uri.https('shop-app-24bba-default-rtdb.firebaseio.com', '/orders.json');
    try {
      var currentTime = DateTime.now();
      List jsonList = cartProducts
          .map((cartProduct) => {
                'id': cartProduct.id,
                'title': cartProduct.title,
                'quantity': cartProduct.quantity,
                'price': cartProduct.price
              })
          .toList();
      final response = await http.post(
        url,
        body: json.encode({
          'id': currentTime.toString(),
          'amount': total,
          'products': jsonList,
          'datetime': currentTime.toIso8601String(),
        }),
      );
      if (response.statusCode >= 400) {
        throw HttpException(message: 'Could not add order.');
      }
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              products: cartProducts,
              datetime: currentTime));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/widgets/product_item.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  Future selectCart(BuildContext ctx) {
    return Navigator.of(ctx).pushNamed('/cart-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show all'),
              )
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
                onPressed: () => selectCart(context),
                icon: const Icon(Icons.shopping_cart)),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(showFavorites: _showOnlyFavorites),
    );
  }
}

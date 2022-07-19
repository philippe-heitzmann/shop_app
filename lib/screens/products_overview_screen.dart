import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/widgets/product_item.dart';
import '../widgets/products_grid.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedvalue) {
              if (selectedvalue == FilterOptions.Favorites) {
                productsData.updateShowFavorites(true);
              } else {
                productsData.updateShowFavorites(false);
              }
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
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem(
  //     {Key? key, required this.id, required this.title, required this.imageUrl})
  //     : super(key: key);

  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return GridTile(
      footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: product.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: product.toggleFavoriteStatus,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          )),
      child: ClipRRect(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

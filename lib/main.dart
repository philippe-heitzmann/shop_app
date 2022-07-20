import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import '../providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      // create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.deepOrange,
                  secondary: Colors.blue,
                  tertiary: Colors.lightBlue,
                ),
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
                bodyMedium: const TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
                bodySmall: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'))),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen()
        },
      ),
    );
  }
}

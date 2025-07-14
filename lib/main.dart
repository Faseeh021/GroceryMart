import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/services/cart_service.dart';
import 'package:grocery_mart/core/services/product_service.dart';
import 'package:grocery_mart/core/bloc/cart/cart_bloc.dart';
import 'package:grocery_mart/core/bloc/product/product_bloc.dart';
import 'package:grocery_mart/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final productService = ProductService();
  final cartService = CartService(sharedPreferences: sharedPreferences);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => productService),
        RepositoryProvider(create: (_) => cartService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              productService: context.read<ProductService>(),
            )..add(const LoadAllProducts()), // ✅ Correct event for Home tab
          ),
          BlocProvider(
            create: (context) => CartBloc(
              cartService: context.read<CartService>(),
            )..add(LoadCart()),
          ),
        ],
        child: const GroceryMartApp(),
      ),
    ),
  );
}

class GroceryMartApp extends StatelessWidget {
  const GroceryMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GroceryMart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

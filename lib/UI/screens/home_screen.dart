import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/bloc/cart/cart_bloc.dart';
import 'package:grocery_mart/core/bloc/product/product_bloc.dart';
import 'package:grocery_mart/core/models/product.dart';
import 'package:grocery_mart/ui/screens/cart_screen.dart';
import 'package:grocery_mart/ui/widgets/product_grid.dart';
import 'package:grocery_mart/ui/widgets/category_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(const LoadAllProducts());
    });
  }

  void _onTabTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0;
          searchQuery = '';
          context.read<ProductBloc>().add(const LoadAllProducts());
        });
      });
    } else {
      setState(() {
        _selectedIndex = index;
        searchQuery = '';
      });

      if (index == 0) {
        context.read<ProductBloc>().add(const LoadAllProducts());
      } else if (index == 1) {
        context.read<ProductBloc>().add(const LoadCategoriesOnly());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroceryMart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.initial ||
              state.status == ProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ProductStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Error loading products'));
          }

          return _selectedIndex == 0
              ? _buildHomeWithSearch(state.products)
              : _buildExploreScreen(state);
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          return BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTabTapped,
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cartState.cartItems.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cartState.cartItems.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                label: "Cart",
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHomeWithSearch(List<Product> allProducts) {
    final filteredProducts = allProducts
        .where((product) =>
        product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Field
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 📦 Filtered Product Grid
            ProductGrid(products: filteredProducts, buttonColor: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreScreen(ProductState state) {
    final selectedCategory = state.selectedCategory;

    if (selectedCategory != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.read<ProductBloc>().add(const LoadCategoriesOnly());
                    Future.delayed(const Duration(milliseconds: 100), () {
                      setState(() {});
                    });
                  },
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  selectedCategory,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ProductGrid(products: state.products, buttonColor: Colors.green),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          CategoryGrid(
            categories: state.categories,
            selectedCategory: null,
            onSelectCategory: (category) {
              if (category != null) {
                context.read<ProductBloc>().add(LoadProducts(category: category));
              }
            },
          ),
        ],
      ),
    );
  }
}

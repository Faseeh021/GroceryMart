import 'package:shared_preferences/shared_preferences.dart';
import 'package:grocery_mart/core/models/cart_item.dart';
import 'package:grocery_mart/core/models/product.dart';
import 'dart:convert';

class CartService {
  final SharedPreferences sharedPreferences;
  static const String _cartKey = 'cart';

  CartService({required this.sharedPreferences});

  Future<void> addToCart(Product product) async {
    final cartItems = await getCartItems();
    final existingIndex = cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity + 1,
      );
    } else {
      cartItems.add(CartItem(product: product));
    }

    await _saveCartItems(cartItems);
  }

  Future<void> removeFromCart(Product product) async {
    final cartItems = await getCartItems();
    cartItems.removeWhere((item) => item.product.id == product.id);
    await _saveCartItems(cartItems);
  }

  Future<void> updateQuantity(Product product, int quantity) async {
    if (quantity <= 0) {
      return removeFromCart(product);
    }

    final cartItems = await getCartItems();
    final existingIndex = cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: quantity,
      );
      await _saveCartItems(cartItems);
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final cartJson = sharedPreferences.getString(_cartKey);
    if (cartJson == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(cartJson);
      return jsonList.map((jsonItem) {
        final productJson = jsonItem['product'];
        final product = Product(
          id: productJson['id'],
          name: productJson['name'],
          price: productJson['price'],
          imageUrl: productJson['imageUrl'],
          category: productJson['category'],
        );
        return CartItem(
          product: product,
          quantity: jsonItem['quantity'],
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearCart() async {
    await sharedPreferences.remove(_cartKey);
  }

  Future<void> _saveCartItems(List<CartItem> cartItems) async {
    final jsonList = cartItems.map((item) {
      return {
        'product': {
          'id': item.product.id,
          'name': item.product.name,
          'price': item.product.price,
          'imageUrl': item.product.imageUrl,
          'category': item.product.category,
        },
        'quantity': item.quantity,
      };
    }).toList();

    await sharedPreferences.setString(_cartKey, json.encode(jsonList));
  }
}
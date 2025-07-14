import 'package:grocery_mart/core/models/product.dart';

class ProductService {
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products; // return all products
  }

  Future<List<Product>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products.where((product) => product.category == 'Fruits').toList();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products.where((product) => product.category == category).toList();
  }



  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Fruits', 'Vegetables', 'Dairy', 'Bakery', 'Beverages'];
  }

  final List<Product> _products = const [
    Product(id: '1', name: 'Apple', price: 1.99, imageUrl: 'assets/images/apple.jpg', category: 'Fruits'),
    Product(id: '2', name: 'Banana', price: 0.99, imageUrl: 'assets/images/banana.jpg', category: 'Fruits'),
    Product(id: '3', name: 'Orange', price: 2.49, imageUrl: 'assets/images/orange.jpg', category: 'Fruits'),
    Product(id: '4', name: 'Tomato', price: 1.49, imageUrl: 'assets/images/tomato.jpg', category: 'Vegetables'),
    Product(id: '5', name: 'Carrot', price: 0.79, imageUrl: 'assets/images/carrot.jpg', category: 'Vegetables'),
    Product(id: '6', name: 'Capsicum', price: 0.79, imageUrl: 'assets/images/capsicum.jpg', category: 'Vegetables'),
    Product(id: '7', name: 'Milk', price: 3.99, imageUrl: 'assets/images/milk.jpg', category: 'Dairy'),
    Product(id: '8', name: 'Cheese', price: 4.99, imageUrl: 'assets/images/cheese.jpg', category: 'Dairy'),
    Product(id: '9', name: 'Curd', price: 4.99, imageUrl: 'assets/images/curd.jpg', category: 'Dairy'),
    Product(id: '10', name: 'Bread', price: 2.99, imageUrl: 'assets/images/bread.jpg', category: 'Bakery'),
    Product(id: '11', name: 'Cookies', price: 1.99, imageUrl: 'assets/images/cookies.jpg', category: 'Bakery'),
    Product(id: '12', name: 'Desserts', price: 1.99, imageUrl: 'assets/images/desserts.jpg', category: 'Bakery'),
    Product(id: '13', name: 'Croissant', price: 1.99, imageUrl: 'assets/images/croissant.jpg', category: 'Bakery'),
    Product(id: '14', name: 'Pepsi Can', price: 1.99, imageUrl: 'assets/images/pepsi.jpg', category: 'Beverages'),
    Product(id: '15', name: '7up Can', price: 1.99, imageUrl: 'assets/images/7up.jpg', category: 'Beverages'),
    Product(id: '16', name: 'Apple Juice', price: 1.99, imageUrl: 'assets/images/applejuice.jpg', category: 'Beverages'),
  ];
}

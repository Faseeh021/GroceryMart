**GroceryMart** is a simple yet functional grocery shopping mobile app built using Flutter and Bloc for state management. It simulates product browsing, category-based exploration, and cart management using local data.

#  Features
# Home Screen

Displays all products

Search bar to filter products by name (real-time)

Add to Cart button on each product

# Explore Screen
Displays all product categories

Tap any category to view its products

Navigate back to categories using the back arrow

# Cart Screen
View all added cart items

Increment, decrement, or remove items

Clear the entire cart

Cart data persists across sessions using SharedPreferences

# Structure

lib/
├── core/
│   ├── bloc/
│   │   ├── cart/
│   │   │   ├── cart_bloc.dart
│   │   │   ├── cart_event.dart
│   │   │   └── cart_state.dart                                                                                                                                                                                      
│   │   └── product/
│   │       ├── product_bloc.dart
│   │       ├── product_event.dart
│   │       └── product_state.dart
│   ├── models/
│   │   ├── cart_item.dart
│   │   └── product.dart
│   ├── services/
│   │   ├── cart_service.dart
│   │   └── product_service.dart
└── ui/
    ├── screens/
    │   ├── cart_screen.dart
    │   └── home_screen.dart
    └── widgets/
        ├── category_chips.dart
        ├── featured_products.dart
        └── product_grid.dart


  # State Management
  
  Uses flutter_bloc to manage two separate state flows:

  ProductBloc – Manages products, categories, and search/filter logic

  CartBloc – Manages cart state with persistent storage

  # Dependencies
  name: grocery_mart
description: "A new Flutter project."

publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: ^3.7.2

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  shared_preferences: ^2.2.2
  cached_network_image: ^3.3.0
  flutter_svg: ^2.0.7
  intl: ^0.18.1

  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.4
  mocktail: ^1.0.4


  flutter_lints: ^5.0.0


flutter:
  uses-material-design: true

  assets:
    - assets/images/apple.jpg
    - assets/images/banana.jpg
    - assets/images/carrot.jpg
    - assets/images/orange.jpg
    - assets/images/tomato.jpg
    - assets/images/bread.jpg
    - assets/images/cheese.jpg
    - assets/images/cookies.jpg
    - assets/images/desserts.jpg
    - assets/images/milk.jpg
    - assets/images/croissant.jpg
    - assets/images/curd.jpg
    - assets/images/capsicum.jpg
    - assets/images/pepsi.jpg
    - assets/images/7up.jpg
    - assets/images/applejuice.jpg
    - assets/images/fruits.jpg
    - assets/images/vegetables.jpg
    - assets/images/dairy.jpg
    - assets/images/bakery.jpg
    - assets/images/beverages.jpg

# Testing
   There are no unit tests added yet. You can enhance the project by writing tests for:

   Bloc logic

  Cart calculations

  Widget UI tests
  
# Notes

No backend is used. All data is local and hardcoded inside ProductService.

Cart uses SharedPreferences to persist data even after app restart.

# How to Use the App

# Launch the App

Open the GroceryMart app on your device.

# Explore Products

The Home tab displays all available grocery products.

Use the search bar at the top to find items by name.

# View by Category

Tap the Explore tab to view products grouped by categories (e.g., Fruits, Vegetables, Dairy).

Tap any category to view products under that category.

Use the back arrow to return to the category list.

# Add to Cart

On product cards, tap the "Add to Cart" button to add items.

Cart item count will show as a badge on the Cart icon.

# Manage Your Cart

Tap the Cart tab to view all items you’ve added.

Use + or - icons to increase or decrease quantity.

Tap the delete icon to remove individual items.

Tap "Clear Cart" to remove all items at once.

# Checkout

Tap the "Checkout" button to simulate a checkout process.

(This is a placeholder – actual checkout functionality is not implemented.)

# Persistence

All cart data is saved locally. If you close and reopen the app, your cart remains intact.


Smooth user experience using BlocBuilder and conditional logic.
# Contributing

Pull requests are welcome! If you’d like to improve UI, performance, or add features like checkout/payment simulation, feel free to contribute.

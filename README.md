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

     

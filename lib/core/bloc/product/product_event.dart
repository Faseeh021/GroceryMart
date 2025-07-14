part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// 👉 Event for loading all products (used in Home tab)
class LoadAllProducts extends ProductEvent {
  const LoadAllProducts();
}

// 👉 Event for loading only category list (no products shown)
class LoadCategoriesOnly extends ProductEvent {
  const LoadCategoriesOnly();
}

// 👉 Event for loading products by a selected category (used in Explore tab)
class LoadProducts extends ProductEvent {
  final String category;

  const LoadProducts({required this.category});

  @override
  List<Object> get props => [category];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_mart/core/models/product.dart';
import 'package:grocery_mart/core/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc({required this.productService}) : super(const ProductState()) {
    on<LoadAllProducts>(_onLoadAllProducts);
    on<LoadCategoriesOnly>(_onLoadCategoriesOnly);
    on<LoadProducts>(_onLoadProducts);
  }

  // 🏠 Load all products (for Home tab)
  Future<void> _onLoadAllProducts(
      LoadAllProducts event,
      Emitter<ProductState> emit,
      ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final categories = await productService.getCategories();
      final products = await productService.getAllProducts();

      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
        categories: categories,
        selectedCategory: null,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: 'Failed to load all products',
      ));
    }
  }

  // 🔍 Load just categories (no products) for Explore tab
  Future<void> _onLoadCategoriesOnly(
      LoadCategoriesOnly event,
      Emitter<ProductState> emit,
      ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final categories = await productService.getCategories();

      emit(state.copyWith(
        status: ProductStatus.success,
        products: const [], // 👈 clear products
        categories: categories,
        selectedCategory: null,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: 'Failed to load categories',
      ));
    }
  }

  // 📦 Load products of a specific category (Explore → Tap category)
  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final categories = await productService.getCategories();
      final products = await productService.getProductsByCategory(event.category);

      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
        categories: categories,
        selectedCategory: event.category,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: 'Failed to load products',
      ));
    }
  }
}

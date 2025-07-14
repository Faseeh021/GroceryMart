import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_mart/core/models/cart_item.dart';
import 'package:grocery_mart/core/models/product.dart';
import 'package:grocery_mart/core/services/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc({required this.cartService}) : super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(
      LoadCart event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final cartItems = await cartService.getCartItems();
      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: cartItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to load cart',
      ));
    }
  }

  Future<void> _onAddToCart(
      AddToCart event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      await cartService.addToCart(event.product);
      final cartItems = await cartService.getCartItems();
      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: cartItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to add to cart',
      ));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      await cartService.removeFromCart(event.product);
      final cartItems = await cartService.getCartItems();
      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: cartItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to remove from cart',
      ));
    }
  }

  Future<void> _onUpdateQuantity(
      UpdateQuantity event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      await cartService.updateQuantity(event.product, event.quantity);
      final cartItems = await cartService.getCartItems();
      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: cartItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to update quantity',
      ));
    }
  }

  Future<void> _onClearCart(
      ClearCart event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      await cartService.clearCart();
      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: const [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to clear cart',
      ));
    }
  }
}
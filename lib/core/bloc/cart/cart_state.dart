part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItem> cartItems;
  final String? errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.cartItems = const [],
    this.errorMessage,
  });

  double get totalPrice {
    return cartItems.fold(0, (total, current) => total + current.totalPrice);
  }

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, cartItems, errorMessage];
}

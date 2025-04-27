import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/add_to_cart_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/delete_cart_item_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/get_cart_item_use_case.dart';
import 'package:mera_bazaar/src/domain/use_cases/cart/update_cart_item_use_case.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;
  final UpdateCartItemUseCase updateCartItemUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
    required this.deleteCartItemUseCase,
    required this.updateCartItemUseCase,
  }) : super(CartInitial()) {
    on<GetCartItemsEvent>(_getCartItems);
    on<AddToCartEvent>(_addToCart);
    on<DeleteCartItemEvent>(_deleteCartItem);
    on<UpdateCartItemEvent>(_updateCartItem);

    add(GetCartItemsEvent());
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(AddToCartLoading());

    final response = await addToCartUseCase.call(cartEntity: event.cartEntity);

    if (response is DataSuccess) {
      emit(AddToCartLoaded(message: response.data!));
      add(GetCartItemsEvent());
    } else {
      emit(AddToCartFailed(message: response.exception!.message));
    }
  }

  Future<void> _getCartItems(
    GetCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(GetCartItemsLoading());

    final response = await getCartItemsUseCase.call();

    if (response is DataSuccess) {
      emit(GetCartItemsLoaded(cartItems: response.data!));
    } else {
      emit(GetCartItemsFailed(message: response.exception!.message));
    }
  }

  Future<void> _deleteCartItem(
    DeleteCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(DeleteCartItemLoading());
    final response = await deleteCartItemUseCase.call(
      cartEntity: event.cartEntity,
    );
    if (response is DataSuccess) {
      emit(DeleteCartItemLoaded(message: response.data!));
    } else {
      emit(DeleteCartItemFailed(message: response.exception!.message));
    }
  }

  Future<void> _updateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    if (event.cartEntity.quantity! <= 0) {
      add(DeleteCartItemEvent(cartEntity: event.cartEntity));
      return;
    }

    emit(UpdateCartItemLoading());

    final response = await updateCartItemUseCase.call(
      cartEntity: event.cartEntity,
    );

    if (response is DataSuccess) {
      emit(UpdateCartItemLoaded(message: response.data!));
    } else {
      emit(UpdateCartItemFailed(message: response.exception!.message));
    }
  }
}

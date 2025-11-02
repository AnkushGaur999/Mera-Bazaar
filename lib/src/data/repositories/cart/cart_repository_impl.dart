import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/cart_repository.dart';

/// Implementation of the cart repository.
///
/// This class implements the [CartRepository] interface and provides
/// concrete implementations for cart-related operations such as:
/// - Adding items to cart
/// - Retrieving cart items
/// - Deleting cart items
/// - Updating cart items

/// A concrete implementation of the [CartRepository] interface.
///
/// This class handles the actual API calls through the [CartDataSource] and
/// converts the responses to domain entities. It also handles error cases by
/// converting exceptions to [MyBazaarException]s.
class CartRepositoryImpl extends CartRepository {
  /// The data source used to make API calls
  final CartDataSource cartDataSource;

  /// Creates a new instance of [CartRepositoryImpl].
  ///
  /// Requires a [CartDataSource] to be provided for making API calls.
  CartRepositoryImpl({required this.cartDataSource});

  @override
  /// Adds an item to the cart.
  ///
  /// This method delegates the API call to the [cartDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A success message string on success
  /// - A [MyBazaarException] on failure
  ///
  /// [cartEntity] - The cart item to add
  Future<DataState<String>> addToCart({required CartEntity cartEntity}) async {
    try {
      final response = await cartDataSource.addToCart(
        cartData: cartEntity.toModel(cartEntity),
      );
      return DataSuccess(data: response);
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  /// Retrieves all items in the cart.
  ///
  /// This method delegates the API call to the [cartDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A list of [CartEntity] on success
  /// - A [MyBazaarException] on failure
  Future<DataState<List<CartEntity>>> getCartItems() async {
    try {
      final response = await cartDataSource.getCartItems();
      return DataSuccess(data: response.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  /// Deletes an item from the cart.
  ///
  /// This method delegates the API call to the [cartDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A success message string on success
  /// - A [MyBazaarException] on failure
  ///
  /// [id] - The ID of the cart item to delete
  Future<DataState<String>> deleteCartItem({required int id}) async {
    try {
      final response = await cartDataSource.deleteCartItem(id: id);
      return DataSuccess(data: response);
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  /// Updates an item in the cart.
  ///
  /// This method delegates the API call to the [cartDataSource] and wraps the
  /// response in a [DataState]. If an error occurs, it is converted to a
  /// [MyBazaarException] and wrapped in a [DataError].
  ///
  /// Returns a [DataState] containing either:
  /// - A success message string on success
  /// - A [MyBazaarException] on failure
  ///
  /// [cartEntity] - The updated cart item data
  Future<DataState<String>> updateCartItem({
    required CartEntity cartEntity,
  }) async {
    try {
      final response = await cartDataSource.updateCartItem(
        cartData: cartEntity.toModel(cartEntity),
      );
      return DataSuccess(data: response);
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  Future<DataState<CartEntity>> getCartItem({required String id}) async {
    try {
      final result = await cartDataSource.getCartItem(id: id);

      CartEntity entity = result.first.toEntity(result.first);

      return DataSuccess(data: entity);
    } on DioException catch (e) {
      return DataError(exception: MyBazaarException.fromDioError(e));
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }
}

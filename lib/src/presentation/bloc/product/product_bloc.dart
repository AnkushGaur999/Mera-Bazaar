import 'package:equatable/equatable.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/product/get_products_use_case.dart';

part 'product_state.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {
    on<GetProductsEvent>(_getProducts);
  }

  void _getProducts(GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(GetProductsLoading());
    final result = await getProductsUseCase.call(type: event.type);
    if (result is DataSuccess) {
      emit(GetProductsLoaded(products: result.data!));
    } else {
      emit(GetProductsFailed(message: result.exception!.message));
    }
  }
}

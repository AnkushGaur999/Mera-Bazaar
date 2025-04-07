import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/home/carousel_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/home/get_carousel_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCarouselUseCase getCarouselUseCase;

  HomeBloc({required this.getCarouselUseCase}) : super(HomeInitial()) {
    on<GetCarouselsEvent>(_getCarousels);
  }

  Future<void> _getCarousels(
    GetCarouselsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(GetCarouselLoading());

    final response = await getCarouselUseCase.call();

    if (response is DataSuccess) {
      emit(GetCarouselLoaded(carousels: response.data!));
    } else {
      emit(GetCarouselFailed(message: response.exception!.message));
    }
  }
}

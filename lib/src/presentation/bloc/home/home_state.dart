part of 'home_bloc.dart';

sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

final class GetCarouselLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

final class GetCarouselLoaded extends HomeState {
  final List<CarouselEntity> carousels;

  GetCarouselLoaded({required this.carousels});

  @override
  List<Object?> get props => [carousels];
}

final class GetCarouselFailed extends HomeState {
  final String message;

  GetCarouselFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

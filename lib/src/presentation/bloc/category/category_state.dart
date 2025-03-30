
part of 'category_bloc.dart';

@immutable
sealed class CategoryState extends Equatable{

}

final class CategoryInitial extends CategoryState{
  @override
  List<Object?> get props => [];
}

final class CategoryLoading extends CategoryState{
  @override
  List<Object?> get props => [];

}

final class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  CategoryLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];

}

final class CategoryFailed extends CategoryState {
  final String message;
  CategoryFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

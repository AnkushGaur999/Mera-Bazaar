part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent extends Equatable{

}

final class GetCategoriesEvent extends CategoryEvent{
  @override
  List<Object?> get props => [];
}

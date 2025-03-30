import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/category/category_use_case.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase categoryUseCase;

  CategoryBloc({required this.categoryUseCase}) : super(CategoryInitial()) {
    on<GetCategoriesEvent>(_getCategories);
  }

  Future<void> _getCategories(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final categories = await categoryUseCase.call();

    emit(CategoryLoaded(categories: categories));
  }
}

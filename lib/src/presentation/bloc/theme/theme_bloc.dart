

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeLoad>{

  ThemeBloc() : super(ThemeLoad(themeData: ThemeData.light())) {

    on<GetThemeEvent>((event, emit) {
      emit(ThemeLoad(themeData: event.themeData));
    });

    on<UpdateThemeEvent>((event, emit) {
      emit(ThemeLoad(themeData: event.themeData));
    });
  }

}
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int countSubhanAllah = 0;
  int countAlhamdullah =0;
  int countAllahAkbar =0;
  int countLaElahElaAllah =0;

  void sebha()
  {
    emit(SebhaState());
  }


}





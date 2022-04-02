import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/models/soura_model.dart';
import 'package:nakhtm/shared/network/shared/dio_helper.dart';
import '../shared/network/end_points.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

}





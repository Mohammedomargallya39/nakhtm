import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/shared/network/local/cache_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
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

  int? juza = 0;
  int? ayahNum = 0;
  String? surahName = 'لم تقرأ بعد';
  String? ayah = 'لم تقرأ بعد';
  void lastRead(
      // {
      // required String sharedSurahName,
      // required String sharedAyah,
      // required int sharedAyahNum,
      // required int sharedJuza
      // }
      )
  {

    emit(LastRead());

    // // ignore: unnecessary_null_comparison
    // if (sharedSurahName != null || sharedAyah != null || sharedAyahNum != null || sharedJuza != null) {
    //   juza = sharedJuza;
    //   ayah = sharedAyah;
    //   ayahNum = sharedAyahNum;
    //   surahName = sharedSurahName;
    //   emit(LastRead());
    // } else {
    //   juza;
    //   ayah;
    //   ayahNum;
    //   surahName;
    //   CacheHelper.saveData(key: 'juza', value: juza).then((value)
    //   {
    //     emit(LastRead());
    //   });
    //   CacheHelper.saveData(key: 'surahName', value: surahName).then((value)
    //   {
    //     emit(LastRead());
    //   });
    //   CacheHelper.saveData(key: 'ayah', value: ayah).then((value)
    //   {
    //     emit(LastRead());
    //   });
    //   CacheHelper.saveData(key: 'ayahNum', value: ayahNum).then((value)
    //   {
    //
    //   });
    // }
  }
}





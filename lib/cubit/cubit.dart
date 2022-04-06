import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/shared/components/constants.dart';
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

  // int sharedJuza = constJuza;
  // int sharedAyahNum = constAyahNum;
  // String sharedSurahName = constSurahName;
  // String sharedAyah= constAyah;



  int? juza = 0;
  int? ayahNum = 0;
  int? ayatSurahNum = 0;
  int? surahNum = 0;
  String? surahName = 'لم تقرأ بعد';
  String? ayah = 'لم تقرأ بعد';
  void lastRead()
  {
    debugPrint('juza is $juza');
    debugPrint('ayah num is $ayahNum');
    debugPrint('ayat surah num is $ayatSurahNum');
    debugPrint('surah num is $surahNum');
    debugPrint('surah name is $surahName');
    debugPrint('ayah is $ayah');
    constJuza =juza! ;
    constAyahNum = ayahNum! ;
    constAyatSurahNum = ayatSurahNum! ;
    constSurahNum = surahNum! ;
    constSurahName = surahName!;
    constAyah = ayah!;
    debugPrint('shared juza is $constJuza');
    debugPrint('shared ayah num is $constAyahNum');
    debugPrint('shared ayat surah num is $constAyatSurahNum');
    debugPrint('shared surah num is $constSurahNum');
    debugPrint('shared surah name is $constSurahName');
    debugPrint('shared ayah is $constAyah');
    emit(LastRead());

  }

}





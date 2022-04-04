import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakhtm/cubit/cubit.dart';
import 'package:nakhtm/shared/components/constants.dart';
import 'package:nakhtm/shared/network/local/cache_helper.dart';
import 'modules/layout_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await CacheHelper.init();



  juza = CacheHelper.getData(key: 'juza') ?? 0 ;
  ayahNum = CacheHelper.getData(key: 'ayahNum') ?? 0;
  surahName = CacheHelper.getData(key: 'surahName') ?? 'لم تقرأ بعد';
  ayah = CacheHelper.getData(key: 'ayah') ?? 'لم تقرأ بعد';



  Widget? widget;
  widget = LayoutScreen();
  runApp(
      MyApp(
        startWidget: widget,
        ayah: ayah,
        ayahNum: ayahNum,
        juza: juza,
        surahName: surahName,
      )
  );

}
class MyApp extends StatelessWidget {
  final Widget startWidget;
  final String surahName;
  final String ayah;
  final int juza;
  final int ayahNum;
  const MyApp({Key? key,required this.startWidget
    ,required this.surahName,required this.ayah,required this.juza,required this.ayahNum
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset(
              'assets/images/splash.png',
            width: double.infinity,
            height: double.infinity,
          ),
          nextScreen: startWidget,
          duration: 1000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
//BlocProvider(create: (context) => AppCubit(),)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakhtm/cubit/cubit.dart';
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
  Widget? widget;
  widget = LayoutScreen();
  runApp(
      MyApp(
        startWidget: widget,
      )
  );

}
class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key,required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit())
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

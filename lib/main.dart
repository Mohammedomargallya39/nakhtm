import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import '/core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'core/util/resources/bloc_observer_manager.dart';
import 'core/util/resources/constants_manager.dart';
import 'features/home/presentation/controller/bloc.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/icon'),
    iOS: DarwinInitializationSettings(),
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await di.init();
  salahTimes = [
    await sl<CacheHelper>().get('fajr') ?? 'Open Network',
    await sl<CacheHelper>().get('sunrise') ?? 'Open Network',
    await sl<CacheHelper>().get('dhuhr') ?? 'Open Network',
    await sl<CacheHelper>().get('asr') ?? 'Open Network',
    await sl<CacheHelper>().get('maghrib') ?? 'Open Network',
    await sl<CacheHelper>().get('ishaa') ?? 'Open Network',
  ];
  adanNotification =  await sl<CacheHelper>().get('adanNotification') ?? false;

  List<String> adan= [
    'حان الآن موعد آذان الفجر',
    'حان الآن موعد آذان الظهر',
    'حان الآن موعد آذان العصر',
    'حان الآن موعد آذان المغرب',
    'حان الآن موعد آذان العشاء',
  ];


  permission = await sl<CacheHelper>().get('permission') ?? false;

  if (permission == true) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLat = position.latitude;
    currentLng = position.longitude;
  }


  if(adanNotification == true)
  {
    Future<void> scheduleDailyNotification() async {

      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'channel id 11',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          colorized: true,
          enableVibration: true,
          sound: UriAndroidNotificationSound('assets/sound/adan.mp3'),
          playSound: true
      );
      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(presentSound: true);
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        1,
        'الآذان',
        adan[0],
        Time(int.parse(salahTimes![0].substring(0,2)),int.parse(salahTimes![0].substring(3,5)),0),
        platformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.showDailyAtTime(
        2,
        'الآذان',
        adan[1],
        Time(int.parse(salahTimes![2].substring(0,2)),int.parse(salahTimes![2].substring(3,5)),0),
        platformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.showDailyAtTime(
        3,
        'الآذان',
        adan[2],
        Time(int.parse(salahTimes![3].substring(0,2)),int.parse(salahTimes![3].substring(3,5)),0),
        platformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.showDailyAtTime(
        4,
        'الآذان',
        adan[3],
        Time(int.parse(salahTimes![4].substring(0,2)),int.parse(salahTimes![4].substring(3,5)),0),
        platformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.showDailyAtTime(
        5,
        'الآذان',
        adan[4],
        Time(int.parse(salahTimes![5].substring(0,2)),int.parse(salahTimes![5].substring(3,5)),0),
        platformChannelSpecifics,
      );
    }
    scheduleDailyNotification();
  }

  debugPrintFullText(salahTimes.toString());
  bool isRtl = false;
  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    isRtl: isRtl,
    translation: translation,
    widget: const SplashScreen(),
    flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
  ));
}

class MyApp extends StatelessWidget {
  final bool isRtl;
  final String translation;
  final Widget widget;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  MyApp(
      {Key? key,
      required this.isRtl,
      required this.translation,
      required this.widget,
      required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppBloc>()
            ..setThemes(
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            )
            ..connectivityListener(),
        ),
        BlocProvider(
          create: (BuildContext context) => sl<HomeCubit>()..getSavedData(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'باسمك اللهم',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppBloc.get(context).lightTheme,
            home: widget,
          );
        },
      ),
    );
  }
}

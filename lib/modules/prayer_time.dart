import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nakhtm/cubit/cubit.dart';
import 'package:nakhtm/cubit/states.dart';
import '../shared/components/components.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PrayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    tz.initializeTimeZones();
    final location = tz.getLocation('Africa/Cairo');

    DateTime date = tz.TZDateTime.from(DateTime.now(), location);
    Coordinates coordinates = Coordinates(26.820553, 30.802498);
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    params.madhab = Madhab.Hanafi;
    PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
    DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr!, location);
    DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise!, location);
    DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr!, location);
    DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr!, location);
    DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib!, location);
    DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha!, location);
    String current = prayerTimes.currentPrayer(date: DateTime.now()); // date: date
    String next = prayerTimes.nextPrayer();
    SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);
    DateTime lastThirdOfTheNight = tz.TZDateTime.from(sunnahTimes.lastThirdOfTheNight, location);

    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context , state) {},
        builder: (context , state)
        {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/background.jpg',
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/1.svg',
                            height: size.height * 0.3,
                            width: size.width,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                size.width * 0.11,
                                size.width * 0.1,
                                size.width * 0.11,
                                size.width * 0.11
                            ),
                            decoration: BoxDecoration(
                              color: Colors.cyan.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(size.width * 0.05),
                            ),
                            child: expentionTile(
                              mainText: "مواعيد الصلاة",
                              mainTextSize: size.width * 0.07,
                              leftPaddingTrailing: size.width * 0.02,
                              topPaddingTrailing: size.height * 0.01,
                              rightPaddingTrailing: size.width * 0.02,
                              bottomPaddingTrailing: size.height * 0.04,
                              iconTrailingSize: size.width * 0.1,
                              secondreyMainFontSize: size.width * 0.04,
                              sizedBoxWidth: size.width * 0.03,
                              thirdFontSize: size.width * 0.04,
                              elFagrText: '$fajrTime'.substring(11,19),
                              elDuhaText: '$sunriseTime'.substring(11,19),
                              elZuhrText: '$dhuhrTime'.substring(11,19),
                              elAsrText:  '$asrTime'.substring(11,19),
                              elMaghrebText: '$maghribTime'.substring(11,19),
                              elEshaaText: '$ishaTime'.substring(11,19),
                              qiamAlayl: '$lastThirdOfTheNight'.substring(11,19),
                              current: current,
                              next: next,

                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          );
        }
    );
  }
}

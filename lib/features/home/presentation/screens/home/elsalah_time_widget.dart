import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_app_bar.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';
import '../../controller/state.dart';
import '../../widgets/build_elsalah_item.dart';

class ElsalahTimeWidget extends StatelessWidget {
  const ElsalahTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> elsalahImages = [
      Assets.images.svg.elfagr,
      Assets.images.svg.doha,
      Assets.images.svg.eldhohr,
      Assets.images.svg.elasr,
      Assets.images.png.elmaghrb,
      Assets.images.svg.eleshaa,
    ];

    List<String> elsalah = [
      AppString.elfagr,
      AppString.eldoha,
      AppString.eldhohr,
      AppString.elasr,
      AppString.elmaghrb,
      AppString.eleshaa,
    ];
    List<String>? timers;
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);


    homeCubit.alarmIcon = adanNotification!;

    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
       return BlocConsumer<HomeCubit, HomeState>(
         listener: (context, state)
         {
           if(state is GetLocationState && appBloc.isAppConnected)
           {
             homeCubit.adan(
                 year: DateTime.now().year.toString(),
                 month: DateTime.now().month.toString(),
                 day: DateTime.now().day.toString(),
                 lat: currentLat.toString(),
                 lng: currentLng.toString(),
                 method: '5'
             );
           }
         },
          builder: (context, state) {
            if (homeCubit.adanResult != null) {
              timers = [
                homeCubit.adanResult![DateTime.now().day - 1].timings.fajr.substring(0, 5),
                homeCubit.adanResult![DateTime.now().day - 1].timings.sunrise.substring(0, 5),
                homeCubit.adanResult![DateTime.now().day - 1].timings.dhuhr.substring(0, 5),
                homeCubit.adanResult![DateTime.now().day - 1].timings.asr.substring(0, 5),
                homeCubit.adanResult![DateTime.now().day - 1].timings.maghrib.substring(0, 5),
                homeCubit.adanResult![DateTime.now().day - 1].timings.ishaa.substring(0, 5),
              ];
            } else{
              timers = salahTimes;
            }
            return Scaffold(
              appBar: defaultAppBar(
                  context: context,
                  appBarBackground: Assets.images.svg.elsalahTimeAppBar
              ),
              body: state is AdanLoadingState || state is LoadingGetLocationState? const Center(child: CircularProgressIndicator()) :Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        Assets.images.png.appBackground,
                      ),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: designApp,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const DefaultText(
                                    title: AppString.elsalahAlarm,
                                    style: Style.small),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {
                                    homeCubit.changAlarm();
                                    adanNotification = await sl<CacheHelper>()
                                        .get('adanNotification');
                                  },
                                  child: SvgPicture.asset(homeCubit.alarmIcon
                                      ? Assets.images.svg.alarmTrue
                                      : Assets.images.svg.alarmFalse),
                                )
                              ],
                            ),
                            verticalSpace(1.h),
                            if(salahTimes![0] != 'Open Network')
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(15.rSp),
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  physics: const BouncingScrollPhysics(),
                                  children: List.generate(
                                      elsalahImages.length,
                                          (index) => BuildElsalahItem(
                                        elsalahImage: elsalahImages[index],
                                        elsalah: elsalah[index],
                                        indexImage: index,
                                        timer: timers![index],
                                      )),
                                ),
                              ),
                            ),
                            if(salahTimes![0] == 'Open Network')
                            const Spacer(),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(Assets.images.svg.salahZekr),
                                  FittedBox(
                                      fit: BoxFit.cover,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 25.rSp),
                                        child: DefaultText(
                                          title:
                                          'إن الصلاة كانت على المؤمنين كتابا موقوتا',
                                          style: Style.extraSmall,
                                          fontSize: 16.rSp,
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

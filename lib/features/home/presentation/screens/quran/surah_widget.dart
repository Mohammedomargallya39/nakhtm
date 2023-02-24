import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/option_dialog.dart';
import '../../../../../core/util/widgets/tafseer_dialog.dart';
import '../../controller/bloc.dart';
import '../../controller/state.dart';

class SurahWidget extends StatelessWidget {
  SurahWidget({Key? key, required this.surahNumber}) : super(key: key);

  int surahNumber;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    int? pressedIndex;
    final player = AudioPlayer();

    ScrollController scrollController = ScrollController();

    void scrollToAyah(int index) {
      scrollController.animateTo(
        index * 100.h,
        duration: const Duration(milliseconds: 100),
        curve: Curves.slowMiddle,
      );
    }

    Timer(const Duration(milliseconds: 500), () {
      if (ayahNum != 0 && surahNum == surahNumber) {
        scrollToAyah(ayahNum! - 1);
      }
    });
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is TafseerSuccessState) {
          showDialog(
            context: context,
            builder: (context) {
              return TafseerDialog(tafseer: homeCubit.tafseerResult!.tafseer);
            },
          );
        }
      },
      builder: (context, state) {
        debugPrintFullText(ayahNum.toString());
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              homeCubit.ayahPressedValue = false;
              homeCubit.changePlayingValue = false;
              player.stop();
              return true;
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: Padding(
                  padding: designApp,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DefaultText(
                              align: TextAlign.end,
                              title: quran.getSurahNameArabic(surahNumber),
                              style: Style.medium,
                              fontSize: 30.rSp,
                              fontFamily: 'arabic',
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                homeCubit.ayahPressedValue = false;
                                homeCubit.changePlayingValue = false;
                                player.stop();
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              verticalSpace(5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Image.asset(Assets.images.png.surahCard),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          DefaultText(
                                            align: TextAlign.end,
                                            title: quran.getSurahNameArabic(
                                                surahNumber),
                                            style: Style.medium,
                                            fontSize: 20.rSp,
                                            color: ColorsManager.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'arabic',
                                          ),
                                          verticalSpace(1.h),
                                          if (surahNumber != 1 &&
                                              surahNumber != 9)
                                            DefaultText(
                                              align: TextAlign.end,
                                              title: 'بسم الله الرحمن الرحيم',
                                              style: Style.medium,
                                              fontSize: 20.rSp,
                                              color: ColorsManager.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'arabic',
                                            ),
                                        ],
                                      ),
                                    ]),
                              ),
                              verticalSpace(1.h),
                              ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (pressedIndex == index) {
                                        homeCubit.ayahPressed(false);
                                      } else {
                                        pressedIndex = index;
                                        homeCubit.ayahPressed(true);
                                        homeCubit.changePlaying(value: false);
                                        player.stop();
                                      }
                                    },
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return OptionsDialog(
                                            message: 'إختر',
                                            firstButtonText: 'التفسير الميسر',
                                            secondButtonText: 'تفسير الجلالين',
                                            thirdButtonText: 'تفسير السعدي',
                                            fourthButtonText: 'تفسير ابن كثير',
                                            fifthButtonText: 'تفسير الطنطاوي',
                                            sixthButtonText: 'تفسير البغوي',
                                            seventhButtonText: 'تفسير القرطبي',
                                            eighthButtonText: 'تفسير الطبري',
                                            height: 40.h,
                                            firstButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 1,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            secondButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 2,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            thirdButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 3,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            fourthButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 4,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            fifthButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 5,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            sixthButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 6,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            seventhButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 7,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                            eighthButtonVoidCallback: () {
                                              homeCubit.tafseer(
                                                  tafseerId: 8,
                                                  surahId: surahNumber,
                                                  ayahId: index + 1);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    onDoubleTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return OptionsDialog(
                                              message: 'إختر',
                                              firstButtonText: 'حفظ',
                                              secondButtonText: 'إالغاء',
                                              firstButtonVoidCallback: () {
                                                homeCubit.getSavedData();
                                                designToastDialog(
                                                    context: context,
                                                    toast: TOAST.info,
                                                    text:
                                                        'تم حفظ أخر ما قرأت بنجاح.');
                                                sl<CacheHelper>()
                                                    .put('ayahNum', index + 1);
                                                sl<CacheHelper>().put(
                                                    'surahNum', surahNumber);
                                                sl<CacheHelper>().put(
                                                    'surahName',
                                                    quran.getSurahNameArabic(
                                                        surahNumber));
                                                sl<CacheHelper>().put(
                                                    'pageNum',
                                                    quran.getPageNumber(
                                                        surahNumber,
                                                        index + 1));
                                              },
                                              secondButtonVoidCallback: () {
                                                Navigator.pop(context);
                                              });
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.rSp),
                                            color: homeCubit.ayahPressedValue ==
                                                        true &&
                                                    pressedIndex == index
                                                ? ColorsManager.lightMainCard
                                                : ayahNum! - 1 == index &&
                                                        surahNumber == surahNum
                                                    ? ColorsManager.mainColor
                                                    : ColorsManager.lightGrey),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 1.h),
                                          child: DefaultText(
                                            title:
                                                '${quran.getVerse(surahNumber, index + 1)} ${quran.getVerseEndSymbol(index + 1)}${quran.isSajdahVerse(surahNumber, index + 1) ? quran.sajdah : ''}',
                                            style: Style.large,
                                            fontSize: 20.rSp,
                                            fontWeight: FontWeight.w600,
                                            align: TextAlign.center,
                                            color:
                                                (homeCubit.ayahPressedValue ==
                                                                true &&
                                                            pressedIndex ==
                                                                index) ||
                                                        (ayahNum! - 1 ==
                                                                index &&
                                                            surahNumber ==
                                                                surahNum)
                                                    ? ColorsManager.white
                                                    : ColorsManager.black,
                                            fontFamily: 'arabic',
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                physics: const BouncingScrollPhysics(),
                                itemCount: quran.getVerseCount(surahNumber),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomSheet: homeCubit.ayahPressedValue
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 80.rSp),
                  width: double.infinity,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    boxShadow: [
                      BoxShadow(
                          color: ColorsManager.darkGrey.withOpacity(0.5),
                          blurRadius: 15.rSp),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: IconButton(
                        padding: EdgeInsets.only(bottom: 5.h),
                        onPressed: () async{
                          player.setSourceUrl(quran.getAudioURLByVerse(surahNumber, pressedIndex! + 1));
                          player.setVolume(1);
                          homeCubit.changePlayingValue == false ?
                          await player.play(UrlSource(quran.getAudioURLByVerse(surahNumber, pressedIndex! + 1))) :
                          await player.pause();
                          player.onPlayerComplete.listen((event)
                          {
                            homeCubit.changePlaying(value: false);
                            debugPrintFullText(homeCubit.changePlayingValue.toString());
                          });
                          homeCubit.changePlaying();
                        },
                        icon: Icon(
                          homeCubit.changePlayingValue == false ? Icons.play_circle : Icons.pause,
                          color: ColorsManager.mainCard,
                          size: 70.rSp,
                        )),
                  ),
                )
              : null,
        );
      },
    );
  }
}

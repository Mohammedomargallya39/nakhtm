import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/core/util/cubit/cubit.dart';
import 'package:nakhtm/core/util/cubit/state.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
import '../../widgets/guide_dialog_widget.dart';

class SurahWidget extends StatefulWidget {
  SurahWidget({Key? key, required this.surahNumber}) : super(key: key);

  int surahNumber;
  final itemScrollController = ItemScrollController();

  @override
  State<SurahWidget> createState() => _SurahWidgetState();
}

class _SurahWidgetState extends State<SurahWidget> {
  Future scrollToItem() async {
    widget.itemScrollController.scrollTo(
        index: ayahNum! - 1,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.bounceIn);
  }

  @override
  void initState() {
    super.initState();
    if (ayahNum != 0 && surahNum == widget.surahNumber && quran.getVerseCount(widget.surahNumber) > 8) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    int? pressedIndex;
    final player = AudioPlayer();

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
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.images.png.appBackground,
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: designApp,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(context: context,
                                    builder: (context) {
                                      return GuideDialog(
                                        onTap: ()
                                        {
                                          Navigator.pop(context);
                                        },
                                        firstGuide:'- لسماع الآيه أنقر علي الآية' ,
                                        secondGuide: '- لقراءة تفسير الآية أنقر مطولا علي الآية',
                                        thirdGuide: '- لحفظ آخر ما قرأت أو نسخ الآية أنقر مرتين متتاليتين علي الآية',
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.help_outline_outlined)),
                            Expanded(
                              child: DefaultText(
                                align: TextAlign.end,
                                title: quran
                                    .getSurahNameArabic(widget.surahNumber),
                                style: Style.medium,
                                fontSize: 30.rSp,
                                fontFamily: 'arabic',
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () async{
                                  Navigator.pop(context);
                                  homeCubit.ayahPressedValue = false;
                                  homeCubit.changePlayingValue = false;
                                  player.stop();
                                },
                                icon: const Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                        verticalSpace(2.h),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ScrollablePositionedList.builder(
                                  shrinkWrap: true,
                                  itemScrollController:
                                      widget.itemScrollController,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        if (index == 0)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  Image.asset(Assets.images.png.surahCard),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      DefaultText(
                                                        align: TextAlign.end,
                                                        title: quran
                                                            .getSurahNameArabic(
                                                                widget
                                                                    .surahNumber),
                                                        style: Style.medium,
                                                        fontSize: 20.rSp,
                                                        color:
                                                            ColorsManager.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'arabic',
                                                      ),
                                                      verticalSpace(1.h),
                                                      if (widget.surahNumber !=
                                                              1 &&
                                                          widget.surahNumber !=
                                                              9)
                                                        DefaultText(
                                                          align: TextAlign.end,
                                                          title:
                                                              'بسم الله الرحمن الرحيم',
                                                          style: Style.medium,
                                                          fontSize: 20.rSp,
                                                          color: ColorsManager
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'arabic',
                                                        ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        if (index == 0) verticalSpace(1.h),
                                        InkWell(
                                          onTap: () {
                                            if (pressedIndex == index) {
                                              homeCubit.ayahPressed();
                                            } else {
                                              pressedIndex = index;
                                              homeCubit.ayahPressed(value: true);
                                              homeCubit.changePlaying(
                                                  value: false);
                                              player.stop();
                                            }
                                          },
                                          onLongPress: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return OptionsDialog(
                                                  message: 'إختر',
                                                  firstButtonText:
                                                      'التفسير الميسر',
                                                  secondButtonText:
                                                      'تفسير الجلالين',
                                                  thirdButtonText:
                                                      'تفسير السعدي',
                                                  fourthButtonText:
                                                      'تفسير ابن كثير',
                                                  fifthButtonText:
                                                      'تفسير الطنطاوي',
                                                  sixthButtonText:
                                                      'تفسير البغوي',
                                                  seventhButtonText:
                                                      'تفسير القرطبي',
                                                  eighthButtonText:
                                                      'تفسير الطبري',
                                                  height: 40.h,
                                                  firstButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 1,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  secondButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 2,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  thirdButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 3,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  fourthButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 4,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  fifthButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 5,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  sixthButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 6,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  seventhButtonVoidCallback:
                                                      () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 7,
                                                        surahId:
                                                            widget.surahNumber,
                                                        ayahId: index + 1);
                                                  },
                                                  eighthButtonVoidCallback: () {
                                                    homeCubit.tafseer(
                                                        tafseerId: 8,
                                                        surahId:
                                                            widget.surahNumber,
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
                                                    secondButtonText: 'نسخ',
                                                    firstButtonVoidCallback:
                                                        () {
                                                      designToastDialog(
                                                          context: context,
                                                          toast: TOAST.info,
                                                          text:
                                                              'تم حفظ أخر ما قرأت بنجاح.');
                                                      sl<CacheHelper>().put('ayahNum', index + 1);
                                                      sl<CacheHelper>().put('surahNum', widget.surahNumber);
                                                      sl<CacheHelper>().put('surahName', quran.getSurahNameArabic(widget.surahNumber));
                                                      sl<CacheHelper>().put('pageNum', quran.getPageNumber(widget.surahNumber, index + 1));
                                                      homeCubit.getSavedData();
                                                        },
                                                    secondButtonVoidCallback:
                                                        () async{
                                                          Clipboard.setData(ClipboardData(text: quran.getVerse(widget.surahNumber, index + 1)));
                                                          designToastDialog(
                                                            context: context,
                                                            toast: TOAST.info,
                                                            text: 'تم النسخ',
                                                          );
                                                    });
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h),
                                            child: Container(
                                              width:double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.rSp),
                                                  color: homeCubit.ayahPressedValue ==
                                                              true &&
                                                          pressedIndex == index
                                                      ? ColorsManager
                                                          .lightMainCard
                                                      : ayahNum! - 1 == index &&
                                                              widget.surahNumber ==
                                                                  surahNum
                                                          ? ColorsManager
                                                              .mainColor
                                                          : ColorsManager
                                                              .lightGrey),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h),
                                                child: DefaultText(
                                                  title:
                                                      '${quran.getVerse(widget.surahNumber, index + 1)} ${quran.getVerseEndSymbol(index + 1)}${quran.isSajdahVerse(widget.surahNumber, index + 1) ? quran.sajdah : ''}',
                                                  style: Style.large,
                                                  fontSize: 20.rSp,
                                                  fontWeight: FontWeight.w600,
                                                  align: TextAlign.center,
                                                  color: (homeCubit.ayahPressedValue ==
                                                                  true &&
                                                              pressedIndex ==
                                                                  index) ||
                                                          (ayahNum! - 1 ==
                                                                  index &&
                                                              widget.surahNumber ==
                                                                  surahNum)
                                                      ? ColorsManager.white
                                                      : ColorsManager.black,
                                                  fontFamily: 'arabic',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(homeCubit.ayahPressedValue && index == quran.getVerseCount(widget.surahNumber)-1)
                                          verticalSpace(10.h)
                                      ],
                                    );
                                  },
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      quran.getVerseCount(widget.surahNumber),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.images.png.appBackground,
                        ),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: ColorsManager.darkGrey.withOpacity(0.5),
                          blurRadius: 15.rSp),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: BlocBuilder<AppBloc,AppState>(
                      builder: (context, state) {
                        return  IconButton(
                            padding: EdgeInsets.only(bottom: 5.h),
                            onPressed: () async {
                              if(appBloc.isAppConnected)
                              {
                                await player.setSourceUrl(quran.getAudioURLByVerse(widget.surahNumber, pressedIndex! + 1));
                                player.setVolume(1);
                                homeCubit.changePlayingValue == false
                                    ? await player.play(UrlSource(
                                    quran.getAudioURLByVerse(widget.surahNumber, pressedIndex! + 1))
                                ): await player.pause();

                                player.onPlayerComplete.listen((event) {
                                  homeCubit.changePlaying(value: false);
                                  debugPrintFullText(homeCubit.changePlayingValue.toString());
                                });
                                homeCubit.changePlaying();
                              }else
                              {
                                designToastDialog(context: context,
                                    toast: TOAST.warning,
                                    text: 'من فضلك قم بتشغيل الإنترنت'
                                );
                              }
                            },
                            icon: Icon(homeCubit.changePlayingValue == false
                                ? Icons.play_circle
                                : Icons.pause_circle,
                              color: ColorsManager.mainCard,
                              size: 70.rSp,
                            ));
                      },
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}

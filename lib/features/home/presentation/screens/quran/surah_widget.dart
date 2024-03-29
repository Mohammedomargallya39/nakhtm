import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/core/util/cubit/cubit.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/features/home/presentation/widgets/surah_audio_item_builder.dart';
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

  final int surahNumber;
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
    if (ayahNum != 0 &&
        surahNum == widget.surahNumber &&
        quran.getVerseCount(widget.surahNumber) > 8) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    int? pressedIndex;
    final player = AudioPlayer();
    if (fontSize != 0) {
      homeCubit.fontSizeValue = fontSize!;
    }
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
              homeCubit.hideCard(false);
              homeCubit.disposeAudio();
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GuideDialog(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        firstGuide:
                                            '- لسماع الآيه أنقر علي الآية',
                                        secondGuide:
                                            '- لقراءة تفسير الآية أنقر مطولا علي الآية',
                                        thirdGuide:
                                            '- لحفظ آخر ما قرأت أو نسخ الآية أنقر مرتين متتاليتين علي الآية',
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.info_outline_rounded)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: InkWell(
                                                  onTap: () {
                                                    if (appBloc.isAppConnected) {

                                                      if(homeCubit.isAudioInit)
                                                      {
                                                        homeCubit.disposeAudio();
                                                        homeCubit.changePlaying(value: false);
                                                      }

                                                      homeCubit.initializeStream();
                                                      homeCubit.initializeAudio(quran.getAudioURLBySurah(homeCubit.shikhId[index], widget.surahNumber));
                                                      homeCubit.hideCard(true);
                                                      Navigator.pop(context);
                                                    } else {
                                                      designToastDialog(
                                                        context: context,
                                                        toast: TOAST.error,
                                                        text:
                                                            'من فضلك قم بتشغيل الإنترنت',
                                                      );
                                                    }
                                                  },
                                                  child: SurahAudioItemBuilder(
                                                      shikhName: homeCubit
                                                          .shikhNames[index])),
                                            );
                                          },
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              homeCubit.shikhNames.length,
                                        ),
                                      );
                                    },
                                  );
                                  homeCubit.ayahPressed(value: false);
                                },
                                icon: const Icon(
                                  Icons.play_circle,
                                  color: ColorsManager.mainCard,
                                )),
                            Expanded(
                              flex: 2,
                              child: DefaultText(
                                align: TextAlign.end,
                                title: quran.getSurahNameArabic(widget.surahNumber),
                                style: Style.medium,
                                fontSize: 30.rSp,
                                fontFamily: 'arabic',
                                maxLines: 1,
                              ),
                            ),
                            horizontalSpace(20.w),
                            Expanded(
                              child: IconButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    homeCubit.ayahPressedValue = false;
                                    homeCubit.changePlayingValue = false;
                                    homeCubit.hideCard(false);
                                    homeCubit.disposeAudio();
                                    player.stop();
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios)),
                            )
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
                                                alignment: AlignmentDirectional
                                                    .topCenter,
                                                children: [
                                                  Image.asset(Assets
                                                      .images.png.surahCard),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      verticalSpace(2.h),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    15.rSp),
                                                        child: Row(
                                                          children: [
                                                            if (homeCubit
                                                                    .fontSizeValue <
                                                                40.rSp)
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    homeCubit
                                                                        .zoomIn();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .rSp),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorsManager
                                                                            .lightGrey
                                                                            .withOpacity(
                                                                                0.3),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.rSp)),
                                                                    child:
                                                                        const DefaultText(
                                                                      align: TextAlign
                                                                          .center,
                                                                      title:
                                                                          'تكبير الخط',
                                                                      style: Style
                                                                          .small,
                                                                      color: ColorsManager
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (homeCubit
                                                                        .fontSizeValue >
                                                                    20.rSp &&
                                                                homeCubit
                                                                        .fontSizeValue <
                                                                    40.rSp)
                                                              horizontalSpace(
                                                                  5.w),
                                                            if (homeCubit
                                                                    .fontSizeValue >
                                                                20.rSp)
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    homeCubit
                                                                        .zoomOut();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .rSp),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorsManager
                                                                            .lightGrey
                                                                            .withOpacity(
                                                                                0.3),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.rSp)),
                                                                    child:
                                                                        const DefaultText(
                                                                      align: TextAlign
                                                                          .center,
                                                                      title:
                                                                          'تصغير الخط',
                                                                      style: Style
                                                                          .small,
                                                                      color: ColorsManager
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      verticalSpace(2.h),
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
                                            if (homeCubit.isStreamInitialized) {
                                              homeCubit.closeStream();
                                              homeCubit.disposeAudio();
                                              homeCubit.hideCard(false);
                                              debugPrintFullText(
                                                  '++++++++++++++++++++++++');
                                            }
                                            if (pressedIndex == index) {
                                              homeCubit.ayahPressed();
                                            } else {
                                              pressedIndex = index;
                                              homeCubit.ayahPressed(value: true);
                                              homeCubit.changePlaying(value: false);
                                              player.stop();
                                            }
                                            if(homeCubit.isAudioInit)
                                            {
                                              homeCubit.disposeAudio();
                                              homeCubit.changePlaying(value: false);
                                            }
                                            homeCubit.initializeStream();
                                            homeCubit.initializeAudio(quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
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
                                                        () async {
                                                      Clipboard.setData(ClipboardData(
                                                          text: quran.getVerse(
                                                              widget
                                                                  .surahNumber,
                                                              index + 1)));
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
                                              width: double.infinity,
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
                                                  title: '${quran.getVerse(widget.surahNumber, index + 1)} ${quran.getVerseEndSymbol(index + 1)}${quran.isSajdahVerse(widget.surahNumber, index + 1) ? quran.sajdah : ''}',
                                                  style: Style.large,
                                                  fontSize: homeCubit.fontSizeValue,
                                                  fontWeight: FontWeight.w600,
                                                  align: TextAlign.center,
                                                  color: (homeCubit.ayahPressedValue == true && pressedIndex == index) || (ayahNum! - 1 == index && widget.surahNumber == surahNum) ? ColorsManager.white : ColorsManager.black,
                                                  fontFamily: 'quran',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (homeCubit.ayahPressedValue &&
                                            index ==
                                                quran.getVerseCount(
                                                        widget.surahNumber) -
                                                    1)
                                          verticalSpace(10.h),
                                        if (homeCubit.hideCardValue &&
                                            index ==
                                                quran.getVerseCount(
                                                        widget.surahNumber) -
                                                    1)
                                          verticalSpace(25.h)
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
                        ),
                        if(homeCubit.ayahPressedValue || homeCubit.hideCardValue)
                        verticalSpace(15.h),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomSheet: homeCubit.ayahPressedValue
              ? Container(
                  //padding: EdgeInsets.symmetric(horizontal: 80.rSp),
                  width: double.infinity,
                  height: 25.h,
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
                  child: StreamBuilder<Duration>(
              stream: homeCubit.streamController.stream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: 3.w, top: 1.h),
                          child: InkWell(
                            onTap: (){
                              homeCubit.ayahPressed(value: false);
                              homeCubit.disposeAudio();
                              homeCubit.changePlaying(value: false);
                              debugPrintFullText('${homeCubit.streamController.isClosed}');
                            },
                            child: const Icon(Icons.close),
                          ),
                        )),
                    Column(
                      children: [
                        Slider(
                          value:
                          snapshot.data?.inSeconds.toDouble() ??
                              0,
                          onChanged: (value) {
                            homeCubit.changePlaying(value: true);
                            homeCubit.player.seek(
                                Duration(seconds: value.toInt()));
                          },
                          activeColor: ColorsManager.mainCard,
                          inactiveColor:
                          ColorsManager.mainCard.withOpacity(0.2),
                          min: 0.0,
                          max: homeCubit.durationSeconds.toDouble(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.rSp),
                          child: Row(
                            children: [
                              DefaultText(
                                style: Style.small,
                                title: homeCubit.formatDuration(
                                    snapshot.data?.inSeconds ?? 0),
                              ),
                              const Spacer(),
                              DefaultText(
                                style: Style.small,
                                title: homeCubit.formatDuration(
                                    homeCubit.player.duration
                                        ?.inSeconds ??
                                        0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.rSp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {
                                  // if (homeCubit.player.position.inSeconds > 6) {
                                  //   homeCubit.changePlaying(value: true);
                                  //   homeCubit.player.seek(homeCubit.player.position - const Duration(seconds: 5),
                                  //   );
                                  // }

                                  if (homeCubit.isStreamInitialized) {
                                    homeCubit.closeStream();
                                    homeCubit.disposeAudio();
                                    homeCubit.hideCard(false);
                                    debugPrintFullText(
                                        '++++++++++++++++++++++++');
                                  }
                                  if(pressedIndex != 0){
                                    pressedIndex = pressedIndex! - 1;
                                    homeCubit.ayahPressed(value: true);
                                      homeCubit.changePlaying(value: false);
                                      player.stop();
                                      if(homeCubit.isAudioInit)
                                      {
                                        homeCubit.disposeAudio();
                                        homeCubit.changePlaying(value: false);
                                      }
                                      homeCubit.initializeStream();
                                    homeCubit.initializeAudio(quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_previous,
                                  color: ColorsManager.mainCard,
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {
                                  if (homeCubit.player.position.inSeconds > 6) {
                                    homeCubit.changePlaying(value: true);
                                    homeCubit.player.seek(homeCubit.player.position - const Duration(seconds: 5),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.replay_5,
                                  color: ColorsManager.mainCard,
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                padding: EdgeInsets.only(bottom: 5.h),
                                onPressed: () async {
                                  if (appBloc.isAppConnected) {
                                    homeCubit.player.setVolume(1);
                                    debugPrintFullText(
                                        homeCubit.playingValue);
                                    homeCubit.changePlaying();
                                    if (homeCubit.changePlayingValue) {
                                      await homeCubit.player.play().then((value){
                                        if(homeCubit.player.playerState.processingState.name == 'completed'){
                                          if (homeCubit.isStreamInitialized) {
                                            homeCubit.closeStream();
                                            homeCubit.disposeAudio();
                                            homeCubit.hideCard(false);
                                            debugPrintFullText(
                                                '++++++++++++++++++++++++');
                                          }
                                          pressedIndex;
                                          homeCubit.ayahPressed(value: true);
                                          homeCubit.changePlaying(value: false);
                                          player.stop();
                                          if(homeCubit.isAudioInit)
                                          {
                                            homeCubit.disposeAudio();
                                            homeCubit.changePlaying(value: false);
                                          }
                                          homeCubit.initializeStream();
                                          homeCubit.initializeAudio(quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
                                        }
                                      });

                                    } else {
                                      await homeCubit.player.pause();
                                    }
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text:
                                        'من فضلك قم بتشغيل الإنترنت');
                                  }
                                },
                                icon: Icon(
                                  homeCubit.changePlayingValue ==
                                      false
                                      ? Icons.play_circle
                                      : Icons.pause_circle,
                                  color: ColorsManager.mainCard,
                                  size: 70.rSp,
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {
                                  if (homeCubit.player.position.inSeconds < homeCubit.player.duration!.inSeconds - 6) {
                                    homeCubit.changePlaying(value: true);
                                    homeCubit.player.seek(
                                      homeCubit.player.position + const Duration(seconds: 5),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.forward_5,
                                  color: ColorsManager.mainCard,
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {
                                  // if (homeCubit.player.position.inSeconds > 6) {
                                  //   homeCubit.changePlaying(value: true);
                                  //   homeCubit.player.seek(homeCubit.player.position - const Duration(seconds: 5),
                                  //   );
                                  // }
                                  if (homeCubit.isStreamInitialized) {
                                    homeCubit.closeStream();
                                    homeCubit.disposeAudio();
                                    homeCubit.hideCard(false);
                                    debugPrintFullText(
                                        '++++++++++++++++++++++++');
                                  }
                                  if(pressedIndex != quran.getVerseCount(widget.surahNumber) - 1){
                                    pressedIndex = pressedIndex! + 1;
                                    homeCubit.ayahPressed(value: true);
                                    homeCubit.changePlaying(value: false);
                                    player.stop();
                                    if(homeCubit.isAudioInit)
                                    {
                                      homeCubit.disposeAudio();
                                      homeCubit.changePlaying(value: false);
                                    }
                                    homeCubit.initializeStream();
                                    homeCubit.initializeAudio(quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: ColorsManager.mainCard,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            // child: Padding(
            //           padding: EdgeInsets.only(bottom: 2.h),
            //           child: IconButton(
            //               padding: EdgeInsets.only(bottom: 5.h),
            //               onPressed: () async {
            //                 if (appBloc.isAppConnected) {
            //                   debugPrintFullText(quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
            //                   await player.setSourceUrl(
            //                       quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
            //                   player.setVolume(1);
            //                   homeCubit.changePlayingValue == false
            //                       ? await player.play(UrlSource(
            //                           quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1)))
            //                       : await player.pause();
            //                   player.onPlayerComplete.listen((event) {
            //                     homeCubit.changePlaying(value: false);
            //                     debugPrintFullText(homeCubit.changePlayingValue.toString());
            //                   });
            //                   homeCubit.changePlaying();
            //                 } else {
            //                   designToastDialog(
            //                       context: context,
            //                       toast: TOAST.warning,
            //                       text: 'من فضلك قم بتشغيل الإنترنت');
            //                 }
            //               },
            //               icon: Icon(
            //                 homeCubit.changePlayingValue == false
            //                     ? Icons.play_circle
            //                     : Icons.pause_circle,
            //                 color: ColorsManager.mainCard,
            //                 size: 70.rSp,
            //               )),
            //       ),
                )
              : homeCubit.hideCardValue
                  ? Container(
                      width: double.infinity,
                      height: 25.h,
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
                              blurRadius: 20.rSp),
                        ],
                      ),
                      child: StreamBuilder<Duration>(
                        stream: homeCubit.streamController.stream,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        end: 3.w, top: 1.h),
                                    child: InkWell(
                                      onTap: (){
                                        homeCubit.hideCard(false);
                                        homeCubit.disposeAudio();
                                        homeCubit.changePlaying(value: false);
                                        debugPrintFullText(
                                            '${homeCubit.streamController.isClosed}');
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  )),
                              Column(
                                children: [
                                  Slider(
                                    value:
                                        snapshot.data?.inSeconds.toDouble() ??
                                            0,
                                    onChanged: (value) {
                                      homeCubit.changePlaying(value: true);
                                      homeCubit.player.seek(
                                          Duration(seconds: value.toInt()));
                                    },
                                    activeColor: ColorsManager.mainCard,
                                    inactiveColor:
                                        ColorsManager.mainCard.withOpacity(0.2),
                                    min: 0.0,
                                    max: homeCubit.durationSeconds.toDouble(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.rSp),
                                    child: Row(
                                      children: [
                                        DefaultText(
                                          style: Style.small,
                                          title: homeCubit.formatDuration(
                                              snapshot.data?.inSeconds ?? 0),
                                        ),
                                        const Spacer(),
                                        DefaultText(
                                          style: Style.small,
                                          title: homeCubit.formatDuration(
                                              homeCubit.player.duration
                                                      ?.inSeconds ??
                                                  0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.rSp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: IconButton(
                                          onPressed: () {
                                            if (homeCubit.player.position.inSeconds > 11) {
                                              homeCubit.changePlaying(value: true);
                                              homeCubit.player.seek(homeCubit.player.position - const Duration(seconds: 10),
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.replay_10,
                                            color: ColorsManager.mainCard,
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          padding: EdgeInsets.only(bottom: 5.h),
                                          onPressed: () async {
                                            if (appBloc.isAppConnected) {
                                              homeCubit.player.setVolume(1);
                                              debugPrintFullText(
                                                  homeCubit.playingValue);
                                              homeCubit.changePlaying();
                                              if (homeCubit
                                                  .changePlayingValue) {
                                                await homeCubit.player.play().then((value){
                                                  if(homeCubit.player.playerState.processingState.name == 'completed'){
                                                    homeCubit.changePlaying(value: false);
                                                    homeCubit.hideCard(false);
                                                    homeCubit.disposeAudio();
                                                  }
                                                });

                                              } else {
                                                await homeCubit.player.pause();
                                              }
                                            } else {
                                              designToastDialog(
                                                  context: context,
                                                  toast: TOAST.warning,
                                                  text:
                                                      'من فضلك قم بتشغيل الإنترنت');
                                            }
                                          },
                                          icon: Icon(
                                            homeCubit.changePlayingValue ==
                                                    false
                                                ? Icons.play_circle
                                                : Icons.pause_circle,
                                            color: ColorsManager.mainCard,
                                            size: 70.rSp,
                                          )),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: IconButton(
                                          onPressed: () {
                                            if (homeCubit
                                                    .player.position.inSeconds <
                                                homeCubit.player.duration!
                                                    .inSeconds - 11) {
                                              homeCubit.changePlaying(value: true);
                                              homeCubit.player.seek(
                                                  homeCubit.player.position + const Duration(seconds: 10),
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.forward_10_outlined,
                                            color: ColorsManager.mainCard,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : null,
          //null,
        );
      },
    );
  }
}

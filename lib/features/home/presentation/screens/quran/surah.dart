import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/core/util/cubit/cubit.dart';
import 'package:nakhtm/core/util/resources/assets.gen.dart';
import 'package:nakhtm/core/util/resources/colors_manager.dart';
import 'package:nakhtm/core/util/resources/constants_manager.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/core/util/widgets/default_text.dart';
import 'package:nakhtm/core/util/widgets/tafseer_dialog.dart';
import 'package:nakhtm/features/home/presentation/controller/bloc.dart';
import 'package:nakhtm/features/home/presentation/controller/state.dart';
import 'package:nakhtm/features/home/presentation/widgets/guide_dialog_widget.dart';
import 'package:nakhtm/features/home/presentation/widgets/surah_audio_item_builder.dart';
import 'package:nakhtm/features/home/presentation/widgets/surah_page_item_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:quran/quran.dart' as quran;
import 'package:audioplayers/audioplayers.dart';

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
                                                  if (appBloc
                                                      .isAppConnected) {
                                                    if (homeCubit
                                                        .isAudioInit) {
                                                      homeCubit
                                                          .disposeAudio();
                                                      homeCubit.changePlaying(
                                                          value: false);
                                                    }

                                                    homeCubit
                                                        .initializeStream();
                                                    homeCubit.initializeAudio(
                                                        quran.getAudioURLBySurah(
                                                            homeCubit.shikhId[
                                                                index],
                                                            widget
                                                                .surahNumber));
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
                              onPressed: () async {
                                Navigator.pop(context);
                                homeCubit.ayahPressedValue = false;
                                homeCubit.changePlayingValue = false;
                                homeCubit.hideCard(false);
                                homeCubit.disposeAudio();
                                player.stop();
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      verticalSpace(2.h),
                      Expanded(
                        child: PageView.builder(
                          itemCount: quran.getSurahPages(widget.surahNumber).length,
                          itemBuilder: (context, index) =>
                              SurahPageItemBuilder(
                                pageNumber: quran.getSurahPages(widget.surahNumber)[index],
                            isFirstPage: index == 0,
                            surahNumber: widget.surahNumber,
                          ),
                        ),
                      ),
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
                      child: IconButton(
                          padding: EdgeInsets.only(bottom: 5.h),
                          onPressed: () async {
                            if (appBloc.isAppConnected) {
                              debugPrintFullText(quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex! + 1));
                              await player.setSourceUrl(
                                  quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex+ 1));
                              player.setVolume(1);
                              homeCubit.changePlayingValue == false
                                  ? await player.play(UrlSource(
                                      quran.getAudioURLByVerse(homeCubit.selectedShiekh, widget.surahNumber, pressedIndex+ 1)))
                                  : await player.pause();

                              player.onPlayerComplete.listen((event) {
                                homeCubit.changePlaying(value: false);
                                debugPrintFullText(
                                    homeCubit.changePlayingValue.toString());
                              });
                              homeCubit.changePlaying();
                            } else {
                              designToastDialog(
                                  context: context,
                                  toast: TOAST.warning,
                                  text: 'من فضلك قم بتشغيل الإنترنت');
                            }
                          },
                          icon: Icon(
                            homeCubit.changePlayingValue == false
                                ? Icons.play_circle
                                : Icons.pause_circle,
                            color: ColorsManager.mainCard,
                            size: 70.rSp,
                          ))),
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
                                      onTap: () {
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
                                            if (homeCubit
                                                    .player.position.inSeconds >
                                                11) {
                                              homeCubit.changePlaying(
                                                  value: true);
                                              homeCubit.player.seek(
                                                homeCubit.player.position -
                                                    const Duration(seconds: 10),
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
                                                await homeCubit.player
                                                    .play()
                                                    .then((value) {
                                                  if (homeCubit
                                                          .player
                                                          .playerState
                                                          .processingState
                                                          .name ==
                                                      'completed') {
                                                    homeCubit.changePlaying(
                                                        value: false);
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
                                                        .inSeconds -
                                                    11) {
                                              homeCubit.changePlaying(
                                                  value: true);
                                              homeCubit.player.seek(
                                                homeCubit.player.position +
                                                    const Duration(seconds: 10),
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

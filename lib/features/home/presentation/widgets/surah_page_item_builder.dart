import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakhtm/core/di/injection.dart';
import 'package:nakhtm/core/network/local/cache_helper.dart';
import 'package:nakhtm/core/util/cubit/cubit.dart';
import 'package:nakhtm/core/util/resources/assets.gen.dart';
import 'package:nakhtm/core/util/resources/colors_manager.dart';
import 'package:nakhtm/core/util/resources/constants_manager.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/core/util/widgets/default_text.dart';
import 'package:nakhtm/core/util/widgets/option_dialog.dart';
import 'package:nakhtm/features/home/presentation/controller/bloc.dart';
import 'package:quran/quran.dart' as quran;

class SurahPageItemBuilder extends StatelessWidget {
  const SurahPageItemBuilder(
      {Key? key,
      required this.isFirstPage,
      required this.surahNumber,
      required this.pageNumber})
      : super(key: key);
  final bool isFirstPage;
  final int surahNumber;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    int? pressedIndex;
    return Column(
      children: [
        if (isFirstPage)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Stack(alignment: AlignmentDirectional.topCenter, children: [
              Image.asset(Assets.images.png.surahCard),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.rSp),
                    child: Row(
                      children: [
                        if (homeCubit.fontSizeValue < 40.rSp)
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeCubit.zoomIn();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.rSp),
                                decoration: BoxDecoration(
                                    color: ColorsManager.lightGrey
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5.rSp)),
                                child: const DefaultText(
                                  align: TextAlign.center,
                                  title: 'تكبير الخط',
                                  style: Style.small,
                                  color: ColorsManager.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        if (homeCubit.fontSizeValue > 20.rSp &&
                            homeCubit.fontSizeValue < 40.rSp)
                          horizontalSpace(5.w),
                        if (homeCubit.fontSizeValue > 20.rSp)
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeCubit.zoomOut();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.rSp),
                                decoration: BoxDecoration(
                                    color: ColorsManager.lightGrey
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5.rSp)),
                                child: const DefaultText(
                                  align: TextAlign.center,
                                  title: 'تصغير الخط',
                                  style: Style.small,
                                  color: ColorsManager.white,
                                  fontSize: 12,
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
                    title: quran.getSurahNameArabic(surahNumber),
                    style: Style.medium,
                    fontSize: 20.rSp,
                    color: ColorsManager.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'arabic',
                  ),
                  verticalSpace(1.h),
                  if (surahNumber != 1 && surahNumber != 9)
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
        Wrap(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: List.generate(
              quran
                  .getVersesTextByPage(pageNumber, verseEndSymbol: true)
                  .length,
              (index) => RawChip(
                label: Container(
                  child: DefaultText(
                    title:
                        '${quran.getVersesTextByPage(pageNumber, verseEndSymbol: true)[index]} ${quran.isSajdahVerse(surahNumber, quran.getVerseCountByPage(pageNumber)) ? quran.sajdah : ''}',
                    style: Style.large,
                    fontSize: homeCubit.fontSizeValue,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.center,
                    color: (homeCubit.ayahPressedValue == true &&
                                pressedIndex == index) ||
                            (ayahNum! - 1 == index && surahNumber == surahNum)
                        ? ColorsManager.white
                        : ColorsManager.black,
                    fontFamily: 'arabic',
                  ),
                ),
              )),
        ),
      ],
    );
  }
}

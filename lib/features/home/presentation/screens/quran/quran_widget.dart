import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/core/util/widgets/search_widget.dart';
import 'package:nakhtm/features/home/presentation/screens/quran/surah_screen.dart';
import 'package:nakhtm/features/home/presentation/widgets/guide_dialog_widget.dart';
import 'package:quran/quran.dart' as quran;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';
import '../../controller/state.dart';

class QuranWidget extends StatefulWidget {
  QuranWidget({Key? key}) : super(key: key);

  final itemScrollController = ItemScrollController();

  @override
  State<QuranWidget> createState() => _QuranWidgetState();
}

class _QuranWidgetState extends State<QuranWidget> {
  Future scrollToItem() async {
    widget.itemScrollController.scrollTo(
        index: surahNum! - 1,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.bounceIn);
  }

  Map<String, int> surahsInfo = {};

  void initializeSurahInfo() {
    surahsInfo = Map.fromIterables(
        List.generate(114, (index) => quran.getSurahNameArabic(index + 1)),
        List.generate(114, (index) => index + 1));
  }

  @override
  void initState() {
    super.initState();
    initializeSurahInfo();
    if (surahNum != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.surahsInfo = surahsInfo;
    homeCubit.searchList = null;
    TextEditingController searchController = TextEditingController();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Assets.images.png.appBackground,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(25.rSp),
                  DefaultText(
                    title: AppString.quran,
                    style: Style.medium,
                    fontWeight: FontWeight.w600,
                    fontSize: 25.rSp,
                  ),
                  verticalSpace(10.rSp),
                  SearchWidget(
                    onChange: (value) {
                      homeCubit.searchBySurahName(value);
                    },
                    controller: searchController,
                  ),
                  if (surahNum != 0)
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          SvgPicture.asset(
                            Assets.images.svg.quranCard,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DefaultText(
                                  title: 'معدل الختمة',
                                  style: Style.medium,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.rSp,
                                  color: ColorsManager.white,
                                ),
                                verticalSpace(2.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: LinearProgressIndicator(
                                        minHeight: 0.4.h,
                                        backgroundColor: ColorsManager.lightGrey
                                            .withOpacity(0.5),
                                        color: ColorsManager.white,
                                        value:
                                            (pageNum! / quran.totalPagesCount),
                                      ),
                                    ),
                                    verticalSpace(1.h),
                                    DefaultText(
                                      title:
                                          '${((pageNum! / quran.totalPagesCount) * 100).toInt()} %',
                                      style: Style.medium,
                                      fontSize: 15.rSp,
                                      color: ColorsManager.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          Assets.images.png.appBackground,
                                        ),
                                        fit: BoxFit.cover),
                                    color: ColorsManager.lightGrey),
                                child: ScrollablePositionedList.builder(
                                    itemScrollController:
                                        widget.itemScrollController,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  SurahScreen(
                                                    surahNum: homeCubit
                                                                .searchList !=
                                                            null
                                                        ? int.parse(surahsInfo[
                                                                homeCubit
                                                                        .searchList![
                                                                    index]]
                                                            .toString())
                                                        : index + 1,
                                                  ));
                                              homeCubit.searchList = null;
                                              searchController.text = '';
                                              if (showGuideValue) {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return GuideDialog(
                                                      onTap: () {
                                                        homeCubit
                                                            .showGuide(false);
                                                        Navigator.pop(context);
                                                      },
                                                      firstGuide:
                                                          '- لسماع الآيه أنقر علي الآية',
                                                      secondGuide:
                                                          '- لقراءة تفسير الآية أنقر مطولا علي الآية',
                                                      thirdGuide:
                                                          '- لحفظ آخر ما قرأت و نسخ الآية أنقر مرتين متتاليتين علي الآية',
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.rSp,
                                                  horizontal: 40.rSp),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      DefaultText(
                                                        title: homeCubit
                                                                    .searchList !=
                                                                null
                                                            ? homeCubit
                                                                    .searchList![
                                                                index]
                                                            : quran
                                                                .getSurahNameArabic(
                                                                    index + 1),
                                                        style: Style.large,
                                                        fontSize: 20.rSp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'arabic',
                                                        color: index ==
                                                                surahNum! - 1
                                                            ? ColorsManager
                                                                .mainCard
                                                            : ColorsManager
                                                                .black,
                                                      ),
                                                      const Spacer(),
                                                      CircleAvatar(
                                                        maxRadius: 15.rSp,
                                                        backgroundColor:
                                                            ColorsManager
                                                                .mainCard,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 0.8.h),
                                                          child: DefaultText(
                                                            align: TextAlign
                                                                .center,
                                                            title: homeCubit
                                                                        .searchList !=
                                                                    null
                                                                ? surahsInfo[homeCubit
                                                                            .searchList![
                                                                        index]]
                                                                    .toString()
                                                                : '${index + 1}',
                                                            style: Style.medium,
                                                            color: ColorsManager
                                                                .white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.rSp,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  verticalSpace(3.h),
                                                  Container(
                                                    height: 0.1.h,
                                                    width: double.infinity,
                                                    color:
                                                        ColorsManager.darkGrey,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (homeCubit.hideCardValue ==
                                                  false &&
                                              surahNum != 0 &&
                                              index == 113)
                                            verticalSpace(10.h)
                                        ],
                                      );
                                    },
                                    itemCount: homeCubit.searchList != null
                                        ? homeCubit.searchList!.length
                                        : 114),
                              ),
                              Container(
                                height: 0.6.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: ColorsManager.mainCard,
                                    borderRadius:
                                        BorderRadius.circular(15.rSp)),
                              )
                            ],
                          ),
                        ),
                        if (homeCubit.hideCardValue == false && surahNum != 0)
                          Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateTo(context,
                                      SurahScreen(surahNum: surahNum!));
                                },
                                child: Container(
                                  height: 10.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        ColorsManager.lightMainCard,
                                        ColorsManager.mainCard
                                      ]),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.rSp),
                                          topRight: Radius.circular(25.rSp))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.w, right: 5.w),
                                    child: Row(
                                      children: [
                                        DefaultText(
                                          title: surahName!,
                                          style: Style.medium,
                                          fontSize: 30.rSp,
                                          color: ColorsManager.white,
                                          fontFamily: 'arabic',
                                        ),
                                        const Spacer(),
                                        DefaultText(
                                          title: 'إضغط للإستكمال',
                                          fontSize: 15.rSp,
                                          style: Style.extraSmall,
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'arabic',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 0.6.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: ColorsManager.white.withOpacity(0.4),
                                    borderRadius:
                                        BorderRadius.circular(15.rSp)),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/features/home/presentation/screens/quran/surah_screen.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_action_button.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';
import '../../controller/state.dart';

class QuranWidget extends StatelessWidget {
  const QuranWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Assets.images.png.appBackground,
                    ),
                    fit: BoxFit.cover
                ),
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
                  verticalSpace(3.rSp),
                  if(surahNum != 0)
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
                                      backgroundColor: ColorsManager.lightGrey.withOpacity(0.5),
                                      color: ColorsManager.white,
                                      value: (pageNum! / quran.totalPagesCount),
                                    ),
                                  ),
                                  verticalSpace(1.h),
                                  DefaultText(
                                    title: '${((pageNum! / quran.totalPagesCount) * 100).toInt()} %',
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
                      children:
                      [
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      Assets.images.png.appBackground,
                                    ),
                                    fit: BoxFit.cover
                                ),
                                color: ColorsManager.lightGrey
                              ),
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: ()
                                          {
                                            navigateTo(context, SurahScreen(surahNum: index+1,));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 20.rSp, horizontal: 40.rSp),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    DefaultText(
                                                      title: quran.getSurahNameArabic(index+1),
                                                      style: Style.large,
                                                      fontSize: 20.rSp,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'arabic',
                                                    ),
                                                    const Spacer(),
                                                    CircleAvatar(
                                                      maxRadius: 15.rSp,
                                                      backgroundColor: ColorsManager.mainCard,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 0.8.h),
                                                        child: DefaultText(
                                                          align: TextAlign.center,
                                                          title: '${index+1}',
                                                          style: Style.medium,
                                                          color: ColorsManager.white,
                                                          fontWeight: FontWeight.w600,
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
                                                  color: ColorsManager.darkGrey,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(homeCubit.hideCardValue == false && surahNum != 0 && index == 113)
                                          verticalSpace(10.h)
                                      ],
                                    );
                                  },
                                  itemCount: 114
                              ),
                            ),
                            Container(
                              height: 0.6.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: ColorsManager.mainCard,
                                  borderRadius: BorderRadius.circular(15.rSp)
                              ),
                            )
                          ],
                        ),
                        if(homeCubit.hideCardValue == false && surahNum != 0 )
                        Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Container(
                                height: 10.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [ColorsManager.lightMainCard,ColorsManager.mainCard ]),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.rSp),topRight: Radius.circular(25.rSp))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w,right: 5.w),
                                  child: Row(
                                    children: [
                                      defaultActionButton(
                                        onPressed: ()
                                        {
                                          homeCubit.hideCard();
                                        },
                                        icon: Icons.cancel_outlined,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      horizontalSpace(2.w),
                                      DefaultText(
                                        title: surahName!,
                                        style: Style.medium,
                                        fontSize: 30.rSp,
                                        color: ColorsManager.white,
                                        fontFamily: 'arabic',
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: ()
                                        {
                                            navigateTo(context, SurahScreen(surahNum: surahNum!));
                                        },
                                        child: DefaultText(
                                          title: 'إضغط للإستكمال',
                                          fontSize: 15.rSp,
                                          style: Style.extraSmall,
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'arabic',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 0.6.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: ColorsManager.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(15.rSp)
                                ),
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

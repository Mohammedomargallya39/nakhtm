import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/default_text.dart';
import '../controller/bloc.dart';
import '../controller/state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            bottomNavigationBar: Container(
              height: 11.h,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(18.rSp),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ]
              ),
             margin: homeCubit.hideCardValue == true ? EdgeInsetsDirectional.only(bottom:20.rSp,start: 20.rSp,end: 20.rSp) : EdgeInsetsDirectional.only(bottom:0.rSp,start: 0.rSp,end: 0.rSp),
              child: CustomNavigationBar(
                iconSize: 30.0.rSp,
                selectedColor: ColorsManager.black,
                strokeColor: ColorsManager.mainColor,
                unSelectedColor: ColorsManager.lightGrey,
                backgroundColor: ColorsManager.white,
                borderRadius: homeCubit.hideCardValue == true ? Radius.circular(20.rSp) : Radius.circular(0.rSp),
                items: [
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.images.svg.home),
                    title: const DefaultText(title: AppString.home, style: Style.medium),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.images.svg.book),
                    title: const DefaultText(title: AppString.mushaf, style: Style.medium),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.images.svg.starBook),
                    title: const DefaultText(title: AppString.azkar, style: Style.medium),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.images.svg.donition),
                    title: const DefaultText(title: AppString.donition, style: Style.medium),
                  ),
                ],
                currentIndex: homeCubit.initialTabIndex,
                onTap: (index){
                    homeCubit.changeNavBottomScreen(index);
                },
              )
              // GNav(
              //   gap: 2,
              //   rippleColor: Colors.grey[300]!,
              //   hoverColor: Colors.grey[300]!,
              //   activeColor: const Color.fromARGB(255, 248, 96, 13),
              //   iconSize: 30.rSp,
              //   padding: EdgeInsets.symmetric( horizontal: 5.w),
              //   duration: const Duration(milliseconds: 400),
              //   tabBackgroundColor: Colors.grey[300]!,
              //   color: Colors.black,
              //   tabs: [
              //     GButton(
              //       icon: Icons.home,
              //       text: 'الرئيسية',
              //      // leading: SvgPicture.asset(Assets.images.svg.home),
              //     ),
              //     GButton(
              //       icon: Icons.home,
              //       text: 'المصحف',
              //     //  leading: SvgPicture.asset(Assets.images.svg.book),
              //     ),
              //     GButton(
              //       icon: Icons.home,
              //       text: 'أذكار المسلم',
              //      // leading: SvgPicture.asset(Assets.images.svg.book),
              //     ),
              //     GButton(
              //       icon: Icons.home,
              //       text: 'صدقة جارية',
              //     //  leading: SvgPicture.asset(Assets.images.svg.donition),
              //     ),
              //
              //   ],
              //   selectedIndex: homeCubit.initialTabIndex,
              //   onTabChange: (index)
              //   {
              //     homeCubit.changeNavBottomScreen(index);
              //   },
              // ),
            ),
            body: homeCubit.homeWidgets.elementAt(homeCubit.initialTabIndex),
          ),
        );
      },
    );
  }
}

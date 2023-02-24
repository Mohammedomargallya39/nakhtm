import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';
import '../azkar/azkar_view_screen.dart';
import '../tasbeeh/tasbeeh_screen.dart';
import 'ahadeth_screen.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  Stream<int> counterStream = Stream.periodic(const Duration(seconds: 20), (int i) => i);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: designApp,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultText(
                  title: AppString.appName,
                  style: Style.medium,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.rSp,
                  fontFamily: 'arabic',
                ),
                verticalSpace(2.h,),
                SvgPicture.asset(Assets.images.svg.icon),
                verticalSpace(2.h,),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, AzkarViewScreen(azkarIndex: 0,));
                        },
                        child: SvgPicture.asset(Assets.images.svg.morningButton),
                      ),
                    ),
                    horizontalSpace(5.w),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          navigateTo(context, AzkarViewScreen(azkarIndex: 1,));
                        },
                        child: SvgPicture.asset(Assets.images.svg.eveningButton),
                      ),
                    ),
                  ],
                ),
                verticalSpace(1.h,),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          navigateTo(context, const AhadethScreen());
                        },
                        child: SvgPicture.asset(Assets.images.svg.ahadeth),
                      ),
                    ),
                    horizontalSpace(5.w),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          navigateTo(context, const TasbeehScreen());
                        },
                        child: SvgPicture.asset(Assets.images.svg.tasbeh),
                      ),
                    ),
                  ],
                ),
                verticalSpace(2.h,),
                Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SvgPicture.asset(Assets.images.svg.slah),
                      StreamBuilder(
                          stream: counterStream,
                          builder: (context, snapshot) {
                            homeCubit.pickRandomHomeSlah();
                            return Padding(
                              padding: EdgeInsets.fromLTRB(20.rSp, 40.rSp, 20.rSp,0),
                              child: DefaultText(
                                align: TextAlign.center,
                                title: homeCubit.pickedRandom!,
                                style: Style.medium,
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.white,
                                fontSize: 16.rSp,
                              ),
                            );
                          },
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

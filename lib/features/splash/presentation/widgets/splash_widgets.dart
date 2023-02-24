import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../../../../core/util/widgets/default_text.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: ScreenSizes.screenHeight,
          child: SvgPicture.asset(
            Assets.images.svg.background,
            color: ColorsManager.mainColor.withOpacity(0.7),
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.images.svg.icon,
              ),
              verticalSpace(5.h),

              DefaultText(
                title: AppString.appName,
                style: Style.headLarge,
                color: Colors.white,
                fontSize: 50.rSp,
                fontWeight: FontWeight.w600,
                fontFamily: 'arabic',

              ),
              verticalSpace(5.h),
              DefaultText(
                title: AppString.appDescription ,
                style: Style.medium,
                color: Colors.white,
                fontSize: 25.rSp,
                fontFamily: 'arabic',
              ),
            ],
          ),
        )
      ],
    );
  }
}

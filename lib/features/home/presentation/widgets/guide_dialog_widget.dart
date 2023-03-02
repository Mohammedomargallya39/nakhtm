import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/core/util/widgets/myButton.dart';

import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/default_text.dart';

class GuideDialog extends Dialog {
  GuideDialog({Key? key,
    required this.onTap,
    required this.firstGuide,
    required this.secondGuide,
    required this.thirdGuide
  }) : super(key: key);

  VoidCallback onTap;
  String firstGuide;
  String secondGuide;
  String thirdGuide;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: 40.h,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.images.png.appBackground,
                ),
                fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding:  EdgeInsets.all(20.rSp),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultText(
                      title: firstGuide,
                      align: TextAlign.center, style: Style.medium, fontWeight: FontWeight.w600, fontSize: 18.rSp,),
                    verticalSpace(4.h),
                    DefaultText(
                      title: secondGuide, align: TextAlign.center, style: Style.medium, fontWeight: FontWeight.w600, fontSize: 18.rSp,),
                    verticalSpace(4.h),
                    DefaultText(
                      title: thirdGuide, align: TextAlign.center, style: Style.medium, fontWeight: FontWeight.w600, fontSize: 18.rSp,),
                    verticalSpace(6.h),
                    myButton(
                      text: 'حسنا',
                      onPressed: onTap,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

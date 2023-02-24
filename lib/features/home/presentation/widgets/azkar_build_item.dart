import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/default_text.dart';

class AzkarBuildItem extends StatelessWidget {
  AzkarBuildItem({Key? key, this.itemBackground, this.title}) : super(key: key);

  String? itemBackground;
  String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0.rSp),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.rSp),
            color: itemBackground == null ? ColorsManager.buttonAhadeth : Colors.transparent,
        ),
        child: itemBackground != null ? SvgPicture.asset(itemBackground!) : Center(
          child: Padding(
            padding: EdgeInsets.all(10.rSp),
            child: DefaultText(
                title: title!,
                style: Style.medium,
                color: ColorsManager.white,
                fontSize: 18.rSp,
                fontWeight: FontWeight.w600,
                fontFamily: 'arabic',
            ),
          ),
        )
        ),
      );
  }
}

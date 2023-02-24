import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../resources/assets.gen.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_text.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String appBarBackground,
  String ? title,
}){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              SvgPicture.asset(
                appBarBackground,
              ),
              if(title != null)
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: DefaultText(
                  title: title,
                  style: Style.medium,
                  color: ColorsManager.white,
                  fontSize: 18.rSp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w,right: 5.w),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              Assets.images.svg.backIcon,
            ),
          ),
        ),
      ],
    ),
    toolbarHeight: 10.h,
  );
}

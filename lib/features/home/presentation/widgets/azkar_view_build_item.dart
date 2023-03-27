import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/default_text.dart';

class AzkarViewBuildItem extends StatelessWidget {
  AzkarViewBuildItem({Key? key,required this.azkarColor,required this.azkar,required this.repetitionNum}) : super(key: key);

  Color azkarColor;
  String azkar;
  int repetitionNum;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 10.rSp),
      width: double.infinity,

      decoration: BoxDecoration(
        color: azkarColor,
        borderRadius: BorderRadius.circular(10.rSp),
      ),
      child: Column(
        children: [

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5.rSp,vertical: 15.rSp),
            decoration: BoxDecoration(
              color: ColorsManager.azkarColor,
              borderRadius: BorderRadius.circular(10.rSp),
              image: DecorationImage(
                  image: AssetImage(
                    Assets.images.png.appBackground,
                  ),
                  fit: BoxFit.cover
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                child: DefaultText(
                  align: TextAlign.center,
                  title: azkar,
                  style: Style.small,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.8.h),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async{
                      Clipboard.setData(ClipboardData(text: azkar));
                      designToastDialog(
                        context: context,
                        toast: TOAST.info,
                        text: 'تم النسخ',
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: ColorsManager.white,
                            radius: 14.rSp,
                            child: Icon(
                              Icons.copy,
                              color: ColorsManager.darkGrey,
                              size: 14.rSp,
                            )),
                        horizontalSpace(4.w),
                        const DefaultText(
                          title: AppString.copy,
                          style: Style.small,
                          color: ColorsManager.white,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: ColorsManager.white,
                          radius: 14.rSp,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 3.rSp),
                              child: DefaultText(
                                title: '$repetitionNum',
                                style: Style.small,
                                fontSize: 14.rSp,
                              ),
                            ),
                          )),
                      horizontalSpace(4.w),
                      const DefaultText(
                        title: AppString.repeat,
                        style: Style.small,
                        color: ColorsManager.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

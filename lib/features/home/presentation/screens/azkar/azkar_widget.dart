import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../widgets/azkar_build_item.dart';
import 'azkar_view_screen.dart';


class AzkarWidget extends StatelessWidget {
  const AzkarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> itemBackground = [
      Assets.images.svg.morningAzkar,
      Assets.images.svg.eveningAzkar,
      Assets.images.svg.azkarElmasged,
      Assets.images.svg.azkarElnoom,
      Assets.images.svg.azkarElsalah,
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
              DefaultText(
                title: AppString.azkar,
                style: Style.medium,
                fontWeight: FontWeight.w600,
                fontSize: 25.rSp,
              ),
              verticalSpace(8.h),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async{
                      navigateTo(context, AzkarViewScreen(azkarIndex: index,));
                    },
                    child: AzkarBuildItem(
                      itemBackground: itemBackground[index],
                    ),
                  ),
                  itemCount:5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
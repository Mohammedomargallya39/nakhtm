import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_app_bar.dart';
import '../../widgets/azkar_build_item.dart';
import 'hadeth_details_screen.dart';

class AhadethWidget extends StatelessWidget {
  const AhadethWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> ahadethBooks = [
      AppString.elbokhary,
      AppString.moslem,
      AppString.altormozy,
      AppString.ebnMaga,
      AppString.aboDawood,
    ];

    List<String> bookName = [
      'sahih-bukhari',
      'sahih-muslim',
      'al-tirmidhi',
      'ibn-e-majah',
      'abu-dawood',
    ];

    return Column(
      children: [
        defaultAppBar(
            context: context, appBarBackground: Assets.images.svg.appbar_hadeth
        ),
        Expanded(
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
              padding: designApp,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()
                      {
                        navigateTo(context, HadethDetailScreen(
                          title: ahadethBooks[index],
                          bookName: bookName[index],
                        ));
                      },
                      child: AzkarBuildItem
                        (title: ahadethBooks[index],),
                    );
                  },
                  itemCount: ahadethBooks.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

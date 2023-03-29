import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/colors_manager.dart';
import 'package:nakhtm/core/util/resources/constants_manager.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/core/util/widgets/default_text.dart';

class SurahAudioItemBuilder extends StatelessWidget {
  SurahAudioItemBuilder({Key? key, required this.shikhName}) : super(key: key);
  String shikhName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.rSp),
      child: Row(
        children: [
          DefaultText(title: shikhName, style: Style.small),
          const Spacer(),
          const Icon(
            Icons.volume_up,
            color: ColorsManager.mainCard,
          )
        ],
      ),
    );
  }
}

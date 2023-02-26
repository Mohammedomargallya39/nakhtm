import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../resources/assets.gen.dart';
import '../resources/constants_manager.dart';
import 'default_text.dart';

class TafseerDialog extends Dialog {

  String tafseer;

  TafseerDialog({Key? key,required this.tafseer}) : super(key: key);

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
                child: DefaultText(
                  title: tafseer, align: TextAlign.center, style: Style.medium, fontWeight: FontWeight.w600, fontSize: 18.rSp,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

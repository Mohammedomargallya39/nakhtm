import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../resources/assets.gen.dart';
import '../resources/constants_manager.dart';
import 'myButton.dart';
import 'default_text.dart';

class OptionsDialog extends Dialog {
  final String message;
  final String firstButtonText;
  final String secondButtonText;
  final String? thirdButtonText;
  final String? fourthButtonText;
  final String? fifthButtonText;
  final String? sixthButtonText;
  final String? seventhButtonText;
  final String? eighthButtonText;

  final VoidCallback firstButtonVoidCallback;
  final VoidCallback secondButtonVoidCallback;
  final VoidCallback? thirdButtonVoidCallback;
  final VoidCallback? fourthButtonVoidCallback;
  final VoidCallback? fifthButtonVoidCallback;
  final VoidCallback? sixthButtonVoidCallback;
  final VoidCallback? seventhButtonVoidCallback;
  final VoidCallback? eighthButtonVoidCallback;

  final double height;

  const OptionsDialog({
    required this.message,
    required this.firstButtonText,
    required this.secondButtonText,
     this.thirdButtonText,
     this.fourthButtonText,
     this.fifthButtonText,
     this.sixthButtonText,
     this.seventhButtonText,
     this.eighthButtonText,

    required this.firstButtonVoidCallback,
    required this.secondButtonVoidCallback,
     this.thirdButtonVoidCallback,
     this.fourthButtonVoidCallback,
     this.fifthButtonVoidCallback,
     this.sixthButtonVoidCallback,
     this.seventhButtonVoidCallback,
     this.eighthButtonVoidCallback,

    this.height = 160.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: height,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                    title: message, align: TextAlign.center, style: Style.medium, fontWeight: FontWeight.w600,),
                verticalSpace(2.h),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: myButton(
                          onPressed: firstButtonVoidCallback,
                          text: firstButtonText,
                          fontSize: 20.rSp,
                        ),
                      ),
                      horizontalSpace(2.w),
                      Expanded(
                        child: myButton(
                          onPressed: secondButtonVoidCallback,
                          text: secondButtonText,
                          fontSize: 16.rSp,
                        ),
                      ),
                    ],
                  ),
                ),
                if(thirdButtonText != null && fourthButtonText != null)
                  verticalSpace(1.h),
                if(thirdButtonText != null && fourthButtonText != null)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: myButton(
                          onPressed: thirdButtonVoidCallback,
                          text: thirdButtonText!,
                          fontSize: 16.rSp,
                        ),
                      ),
                      horizontalSpace(2.w),
                      Expanded(
                        child: myButton(
                          onPressed: fourthButtonVoidCallback,
                          text: fourthButtonText!,
                          fontSize: 16.rSp,
                        ),
                      ),
                    ],
                  ),
                ),
                if(fifthButtonText != null && sixthButtonText != null)
                  verticalSpace(1.h),
                if(fifthButtonText != null && sixthButtonText != null)
                  Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: myButton(
                          onPressed: fifthButtonVoidCallback,
                          text: fifthButtonText!,
                          fontSize: 16.rSp,
                        ),
                      ),
                      horizontalSpace(2.w),
                      Expanded(
                        child: myButton(
                          onPressed: sixthButtonVoidCallback,
                          text: sixthButtonText!,
                          fontSize: 16.rSp,
                        ),
                      ),
                    ],
                  ),
                ),
                if(seventhButtonText != null && eighthButtonText != null)
                  verticalSpace(1.h),
                if(seventhButtonText != null && eighthButtonText != null)
                  Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: myButton(
                          onPressed: seventhButtonVoidCallback,
                          text: seventhButtonText!,
                          fontSize: 16.rSp,
                        ),
                      ),
                      horizontalSpace(2.w),
                      Expanded(
                        child: myButton(
                          onPressed: eighthButtonVoidCallback,
                          text: eighthButtonText!,
                          fontSize: 16.rSp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

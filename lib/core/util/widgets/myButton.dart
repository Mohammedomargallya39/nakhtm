import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';

class myButton extends StatelessWidget {
  myButton(
      {Key? key,
      this.width = double.infinity,
      this.height,
      this.radius = 20.0,
      this.elevation = 0.0,
      required this.text,
      this.color = ColorsManager.mainColor,
      this.iconWidget,
      this.textOnly = true,
      this.onPressed,
      this.textStyle,
      this.fontSize,
      this.fontWeight})
      : super(key: key);

  final Function()? onPressed;
  final String text;
  final double width;
  final double? height;
  final double radius;
  final double elevation;
  Color? color;
  Widget? iconWidget;
  final bool textOnly;
  TextStyle? textStyle;
  double? fontSize;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: color ?? Theme.of(context).backgroundColor,
        minWidth: width,
        height: height ?? 6.h,
        elevation: elevation,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: textOnly
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(text,
                      style: textStyle ??
                          Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: Colors.white,
                              fontFamily: 'english',
                              fontWeight: FontWeight.w600,
                              fontSize: fontSize)),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconWidget!,
                    horizontalSpace(5.w),
                    Text(text,
                        style: textStyle ??
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: Colors.white,
                                fontFamily: 'english',
                                fontWeight: FontWeight.w600,
                                fontSize: fontSize)),
                  ],
                ),
              ));
  }
}

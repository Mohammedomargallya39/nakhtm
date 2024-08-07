import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'assets.gen.dart';
import 'extensions_manager.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/cubit/cubit.dart';
import '/core/util/resources/translation_manager.dart';
import 'package:flutter/material.dart';
import 'font_manager.dart';

bool isArabic = true;

List<Color> gradientColors = [
  ColorsManager.white,
  ColorsManager.white,
];

/// Translate error message
const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

EdgeInsetsGeometry designApp =  EdgeInsets.all(25.rSp);

Widget svgImage({required String path,Color? color}){
  return color != null ?
  SvgPicture.asset(path ,color: color,height: 28,width: 28,) :
  SvgPicture.asset(path) ;
}


enum Style {
  extraSmall,
  small,
  medium,
  large,
  headLarge,
  headMedium,
  headSmall
}



void navigateTo(context,Widget widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context,Widget widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,),
      (route) {
    return false;
  },
);

String localised({
  required BuildContext context,
  required String ar,
  required String en,
}) {
  if (AppBloc.get(context).isArabic) {
    return ar;
  }
  return en;
}



TranslationModel appTranslation() => LanguageManager.translationModel;



void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}




Future<void> designToastDialog({
  required BuildContext context,
  required TOAST toast,
  String text = '',
  bool isDismissible = true,
}) async {
  return showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (context) => Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Directionality(
        textDirection: AppBloc.get(context).isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          height: 80.0,
          color: ColorsManager.white,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10.0,
                    height: double.infinity,
                    color: chooseColor(toast),
                  ),
                  horizontalSpace(20.rSp),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: chooseColor(toast),
                    child: Icon(
                      chooseIcon(toast),
                      color: ColorsManager.white,
                      size: 18.0,
                    ),
                  ),
                  horizontalSpace(20.rSp),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chooseTitle(toast, context),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorsManager.darkGrey,
                                    fontWeight: FontWeightManager.bold,
                                    fontSize: 18.0.rSp,
                                  ),
                        ),
                        verticalSpace(4.rSp),
                        Text(
                          text.isNotEmpty
                              ? text
                              : appTranslation().deleteMessage,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorsManager.darkGrey,
                              fontWeight: FontWeightManager.regular,
                              fontSize: 14.0.rSp),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(20.rSp),
                ],
              ),
              if (isDismissible)
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: EdgeInsets.all(10.rSp),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        //navigateAndFinish(context, const MainPage());
                      },
                      child: const CircleAvatar(
                        backgroundColor: ColorsManager.surfaceLight,
                        radius: 10.0,
                        child: Icon(
                          Icons.close,
                          size: 10.0,
                          color: ColorsManager.textPrimaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

enum TOAST { success, error, info, warning }

IconData chooseIcon(TOAST toast) {
  late IconData iconData;

  switch (toast) {
    case TOAST.success:
      iconData = FontAwesomeIcons.check;
      break;
    case TOAST.error:
      iconData = FontAwesomeIcons.times;
      break;
    case TOAST.info:
      iconData = FontAwesomeIcons.info;
      break;
    case TOAST.warning:
      iconData = FontAwesomeIcons.exclamation;
      break;
  }

  return iconData;
}

Color chooseColor(TOAST toast) {
  late Color color;

  switch (toast) {
    case TOAST.success:
      color = ColorsManager.success;
      break;
    case TOAST.error:
      color = ColorsManager.redPrimary;
      break;
    case TOAST.info:
      color = ColorsManager.info;
      break;
    case TOAST.warning:
      color = ColorsManager.warning;
      break;
  }

  return color;
}

String chooseTitle(TOAST toast, context) {
  late String title;

  switch (toast) {
    case TOAST.success:
      title = 'نجح';
      break;
    case TOAST.error:
      title = 'خطأ';
      break;
    case TOAST.info:
      title = 'معلومة';
      break;
    case TOAST.warning:
      title = 'تحذير';
      break;
  }

  return title;
}

SizedBox verticalSpace(double size) => SizedBox(height: size);

SizedBox horizontalSpace(double size) => SizedBox(width: size);

BorderRadius borderRadius(double radius) => BorderRadius.circular(radius);

String displayTranslatedText({
  required BuildContext context,
  required String ar,
  required String en,
}) =>
    AppBloc.get(context).isArabic ? ar : en;


double? currentLat;
double? currentLng;

bool? permission;

int? surahNum = 0;
int? ayahNum = 0;
int? pageNum = 0;
String? surahName = 'لم تقرأ بعد';

List<String>? salahTimes;

double? fontSize = 0;

bool showGuideValue = true;

bool? adanNotification = false;

int appVersionCode = 5;

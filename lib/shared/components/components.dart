import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nakhtm/shared/network/shared/dio_helper.dart';

import '../../models/soura_model.dart';
import '../network/end_points.dart';

void navigateAndEnd(context,Widget widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}
void navigateTo(context,Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget),);
}
void showToast({required String message, required ToastStates state}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates{SUCCESS, ERROR , WARNING}
Color toastColor(ToastStates state){
  Color color ;
  switch (state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
Widget defaultButton({
  // Color background = defaultColor,
  double width = double.infinity,
  required dynamic color,
  dynamic textColor = Colors.white,
  double height = 77,
  bool isUpperCase = true,
  double radius = 6.0,
  required Function() function,
  required String text,
  required BuildContext context,
  double fontSize = 16,
}) {
  return  Container(
    alignment: Alignment.center,
    width: width,
    height: height,
    child: AnimatedButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: Theme.of(context).textTheme.button!.copyWith(
          color: textColor,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      enabled: true,
      shadowDegree: ShadowDegree.light,
      color: color,
    ),
  );
}

Widget defaultTextButton({
  required Function()? onPressed,
  required String text,
  required dynamic color,
  double fontSize = 16,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

Widget defaultFormField({
  String? text,
  isPassword = false,
  required TextEditingController controller,
  dynamic prefix,
  ValueChanged<String>? onChange,
  IconData? suffix,
  Function? suffixPressed,
  Function? validate,
  Function? onSubmit,
  required TextInputType type ,
  required context,
  dynamic textColor,
  dynamic labelStyleColor,
  dynamic fillColor,
  dynamic suffixIconColor,
  dynamic borderColor,
  dynamic cursorColor,
  bool? enabled,


  int maxLines = 1,
})
{
  return TextFormField(
    enabled: enabled,
    cursorColor: cursorColor,
    maxLines: maxLines,
    controller: controller,
    obscureText: isPassword,
    onChanged: onChange,
    validator:(value){
      return validate!(value);
    },
    keyboardType: type,
    style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      isDense: true,
      labelText: text,
      filled: false,
      labelStyle: TextStyle(
          color:  labelStyleColor
      ),
      fillColor: fillColor ,
      prefixIcon: prefix,
      suffixIcon: IconButton(onPressed: (){
        return suffixPressed!();
      }, icon: Icon(suffix),color:suffixIconColor,),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0 ),
        borderSide:  BorderSide(color: borderColor , width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0 ),
        borderSide:  BorderSide(color: borderColor , width: 1),
      ),
    ),
  );
}

Widget chooseKhetma(
      {
        required String mainText,
        required double mainTextSize,
        required double leftPaddingTrailing,
        required double topPaddingTrailing,
        required double rightPaddingTrailing,
        required double bottomPaddingTrailing,
        required double iconTrailingSize,
        required double secondreyMainFontSize,
        required double sizedBoxWidth,
        required double thirdFontSize,
        required String numOfElfagr,

      }
    )
{
  return ExpansionTile(
    title: Column(
      children: [
        Row(
          children: [
            Text(
              mainText ,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: mainTextSize
              ),
            ),
          ],
        ),
      ],
    ),
    trailing: Padding(
      padding: EdgeInsets.fromLTRB(
        leftPaddingTrailing,
        topPaddingTrailing,
        rightPaddingTrailing,
        bottomPaddingTrailing,
      ),
      child: Icon(
        Icons.arrow_drop_down, color: Colors.white, size: iconTrailingSize,
      ),
    ),
    children: [
      Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'الفجر' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    numOfElfagr ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'الظهر' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    numOfElfagr ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'العصر' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    numOfElfagr ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'المغرب' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    numOfElfagr ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'العشاء' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    numOfElfagr ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget expentionTile(
    {
      required String mainText,
      required double mainTextSize,
      required double leftPaddingTrailing,
      required double topPaddingTrailing,
      required double rightPaddingTrailing,
      required double bottomPaddingTrailing,
      required double iconTrailingSize,
      required double secondreyMainFontSize,
      required double sizedBoxWidth,
      required double thirdFontSize,
      required String elFagrText,
      required String elDuhaText,
      required String elZuhrText,
      required String elAsrText,
      required String elMaghrebText,
      required String elEshaaText,
      required String qiamAlayl,
      required String next,
      required String current,

    }
    )
{
  return ExpansionTile(
    title: Column(
      children: [
        Row(
          children: [
            Text(
              mainText ,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: mainTextSize
              ),
            ),
          ],
        ),
      ],
    ),
    trailing: Padding(
      padding: EdgeInsets.fromLTRB(
        leftPaddingTrailing,
        topPaddingTrailing,
        rightPaddingTrailing,
        bottomPaddingTrailing,
      ),
      child: Icon(
        Icons.arrow_drop_down, color: Colors.white, size: iconTrailingSize,
      ),
    ),
    children: [
      Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الصلاة الحالية' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    current ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الصلاة التالية' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    next ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          //,,,,,,,,,,
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الفجر' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    elFagrText ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الضحي' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    elDuhaText ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الظهر' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    elZuhrText ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'العصر' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    elAsrText ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'المغرب' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    elMaghrebText ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'العشاء' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    elEshaaText ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
          //........
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'قيام الليل' ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: secondreyMainFontSize
                    ),
                  ),
                ),
                SizedBox(width: sizedBoxWidth,),
                Expanded(
                  flex: 4,
                  child: Text(
                    qiamAlayl ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: thirdFontSize
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget soura(
{
  required double firstContainerWidth,
  required double firstContainerHeight,
  dynamic firstContainerColor,
  required double secondContainerWidth,
  required double secondContainerHeight,
  dynamic secondContainerColor,
  required String souraNum,
  dynamic souraNumColor,
  required double souraNumSize,
  dynamic souraNumWeight,
  required String souraName,
  dynamic souraNameColor,
  required double souraNameSize,
  dynamic souraNameWeight,
  required double leftMargin,
  required double topMargin,
  required double rightMargin,
  required double bottomMargin,
  required double leftPadding,
  required double rightPadding,
  required double topPadding,
  required double bottomPadding,



}
    )
{
  return Container(
    width: firstContainerWidth,
    height: firstContainerHeight,
    margin: EdgeInsets.fromLTRB(
        leftMargin,
        topMargin,
        rightMargin,
        bottomMargin
    ),
    decoration: BoxDecoration(
      color: firstContainerColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Container(
          width: secondContainerWidth,
          height: secondContainerHeight,
          decoration: BoxDecoration(
            color: secondContainerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              souraNum,
              style: TextStyle(
                color: souraNumColor,
                fontSize: souraNumSize,
                fontWeight: souraNumWeight,
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.fromLTRB(
              leftPadding,
              topPadding,
              rightPadding,
              bottomPadding
          ),
          child: Text(
            souraName,
            style: TextStyle(
              color: souraNameColor,
              fontSize: souraNameSize,
              fontWeight: souraNameWeight,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget listTiles ( {
  required mainText,
  required secondText,
  required sizeWidth,
  required sizeHeight,

} )
{
  return Column(
    children: [
      ListTile(
        title: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                secondText ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeWidth * 0.04
                ),
              ),
            ),
            SizedBox(width: sizeWidth * 0.02,),
            Expanded(
              flex: 2,
              child: Text(
                mainText,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: sizeWidth * 0.06
                ),
              ),
            ),

          ],
        ),
      ),
      ListTile(
        title: Container(
          height: sizeHeight * 0.0001,
          width: sizeWidth,
          color: Colors.black,
        ),
      ),
    ],
  );
}


import 'dart:ui';
import 'package:flutter/material.dart';
import '../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      size.height * 0.02,
                      0,
                      size.height * 0.01,
                  ),
                  child: Text(
                    '... أهلا بكم',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.1,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/splash.png',
                  height: size.height * 0.3,
                  width: size.width,
                ),
                SizedBox(height: size.height * 0.04,),
                Text(
                  'أختر الخاتمه',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.07,
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(size.width * 0.11),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                  ),
                  //color: Colors.blueGrey.withOpacity(0.3),
                  child: Column(
                    children: [
                      chooseKhetma(
                          mainText: 'مره واحده',
                          mainTextSize: size.width * 0.055,
                          leftPaddingTrailing: size.width * 0.033,
                          topPaddingTrailing: size.height * 0.011,
                          rightPaddingTrailing: size.width * 0.02,
                          bottomPaddingTrailing: size.height * 0,
                          iconTrailingSize: size.width * 0.088,
                          secondreyMainFontSize: size.width * 0.044,
                          sizedBoxWidth: size.width * 0.02,
                          thirdFontSize: size.width * 0.039,
                          numOfElfagr: '4 صفحات',
                      ),
                      chooseKhetma(
                        mainText: 'مرتان',
                        mainTextSize: size.width * 0.055,
                        leftPaddingTrailing: size.width * 0.033,
                        topPaddingTrailing: size.height * 0.011,
                        rightPaddingTrailing: size.width * 0.02,
                        bottomPaddingTrailing: size.height * 0,
                        iconTrailingSize: size.width * 0.088,
                        secondreyMainFontSize: size.width * 0.044,
                        sizedBoxWidth: size.width * 0.02,
                        thirdFontSize: size.width * 0.039,
                        numOfElfagr: '8 صفحات',
                      ),
                      chooseKhetma(
                        mainText: 'ثلاث مرات',
                        mainTextSize: size.width * 0.055,
                        leftPaddingTrailing: size.width * 0.033,
                        topPaddingTrailing: size.height * 0.011,
                        rightPaddingTrailing: size.width * 0.02,
                        bottomPaddingTrailing: size.height * 0,
                        iconTrailingSize: size.width * 0.088,
                        secondreyMainFontSize: size.width * 0.044,
                        sizedBoxWidth: size.width * 0.02,
                        thirdFontSize: size.width * 0.039,
                        numOfElfagr: '12 صفحات',
                      ),
                      chooseKhetma(
                        mainText: 'خمس مرات',
                        mainTextSize: size.width * 0.055,
                        leftPaddingTrailing: size.width * 0.033,
                        topPaddingTrailing: size.height * 0.011,
                        rightPaddingTrailing: size.width * 0.02,
                        bottomPaddingTrailing: size.height * 0,
                        iconTrailingSize: size.width * 0.088,
                        secondreyMainFontSize: size.width * 0.044,
                        sizedBoxWidth: size.width * 0.02,
                        thirdFontSize: size.width * 0.039,
                        numOfElfagr: '20 صفحات',
                      ),
                      chooseKhetma(
                        mainText: 'ست مرات',
                        mainTextSize: size.width * 0.055,
                        leftPaddingTrailing: size.width * 0.033,
                        topPaddingTrailing: size.height * 0.011,
                        rightPaddingTrailing: size.width * 0.02,
                        bottomPaddingTrailing: size.height * 0,
                        iconTrailingSize: size.width * 0.088,
                        secondreyMainFontSize: size.width * 0.044,
                        sizedBoxWidth: size.width * 0.02,
                        thirdFontSize: size.width * 0.039,
                        numOfElfagr: '24 صفحات',
                      ),
                      chooseKhetma(
                        mainText: 'عشر مرات',
                        mainTextSize: size.width * 0.055,
                        leftPaddingTrailing: size.width * 0.033,
                        topPaddingTrailing: size.height * 0.011,
                        rightPaddingTrailing: size.width * 0.02,
                        bottomPaddingTrailing: size.height * 0,
                        iconTrailingSize: size.width * 0.088,
                        secondreyMainFontSize: size.width * 0.044,
                        sizedBoxWidth: size.width * 0.02,
                        thirdFontSize: size.width * 0.039,
                        numOfElfagr: '40 صفحات',
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

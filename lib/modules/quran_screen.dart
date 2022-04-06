import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/cubit/states.dart';
import 'package:nakhtm/shared/components/constants.dart';
import '../cubit/cubit.dart';
import '../shared/components/components.dart';
import 'soura_screen.dart';
import 'package:quran/quran.dart' as quran;


class QuranScreen extends StatelessWidget {
  List<String> souraNum =
  [
    '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25',
    '26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50',
    '51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75',
    '76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100',
    '101','102','103','104','105','106','107','108','109','110','111','112','113','114'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                'assets/images/background.jpg',
                height: size.height,
                width: size.width,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // SvgPicture.asset(
                      //
                      // ),
                      SizedBox(height: size.height * 0.04,),
                      Image.asset(
                        'assets/images/4.png',
                        height: size.height * 0.3,
                        width: size.width,
                      ),
                      SizedBox(height: size.height * 0.04,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.width * 0.02),
                          color: Colors.cyan,
                        ),
                        width: size.width,
                        margin: EdgeInsets.fromLTRB(
                            size.width * marginLeft,
                            size.width * marginTop,
                            size.width * marginRight,
                            size.width * marginBottom
                        ),
                        child: ExpansionTile(
                          title: Text(
                            'معلومات عن القرآن',
                            style: TextStyle(
                                fontSize: size.width * mainFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          children: [
                            Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${quran.totalJuzCount}' ,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * thirdFontSize
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03,),
                                      Expanded(
                                        child: Text(
                                          'عدد الأجزاء' ,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * secondFontSize,
                                              fontWeight: FontWeight.bold
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
                                        child: Text(
                                          '${quran.totalSurahCount}' ,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * thirdFontSize
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03,),
                                      Expanded(
                                        child: Text(
                                          'عدد السور' ,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * secondFontSize,
                                              fontWeight: FontWeight.bold
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
                                        child: Text(
                                          '${quran.totalMakkiSurahs}' ,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * thirdFontSize
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03,),
                                      Expanded(
                                        child: Text(
                                          'عدد السور المكية' ,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * secondFontSize,
                                              fontWeight: FontWeight.bold
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
                                        child: Text(
                                          '${quran.totalMadaniSurahs}' ,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * thirdFontSize
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03,),
                                      Expanded(
                                        child: Text(
                                          'عدد السور المدنية' ,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * secondFontSize,
                                              fontWeight: FontWeight.bold
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
                                        flex: 4,
                                        child: Text(
                                          '${quran.totalPagesCount}' ,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * thirdFontSize
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03,),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'عدد صفحات' ,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * secondFontSize,
                                              fontWeight: FontWeight.bold
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
                                        flex: 4,
                                        child: Text(
                                          '${quran.totalVerseCount}' ,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * thirdFontSize
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03,),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'عدد الآيات' ,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * secondFontSize,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.width * 0.02),
                          color: Colors.cyan,
                        ),
                        width: size.width,
                        margin: EdgeInsets.fromLTRB(
                            size.width * marginLeft,
                            size.width * marginTop,
                            size.width * marginRight,
                            size.width * marginBottom,
                        ),
                        child: ExpansionTile(
                          title: Text(
                            'السور',
                            style: TextStyle(
                                fontSize: size.width * mainFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context,index)
                              {
                                return Column(
                                  children: [
                                    SizedBox(height: size.height * 0.02,),
                                    InkWell(
                                      child: soura(
                                        secondContainerWidth: size.width * 0.2,
                                        souraNum: souraNum[index],
                                        souraNumSize: size.width * thirdFontSize,
                                        souraName: quran.getSurahNameArabic(int.parse(souraNum[index])),
                                        souraNameSize: size.width * secondFontSize,
                                        bottomMargin: size.height * 0.01,
                                        leftMargin: size.width * 0,
                                        rightMargin: size.width * 0,
                                        topMargin: size.height * 0.01,
                                        firstContainerColor: Colors.cyan.withOpacity(0.1),
                                        secondContainerColor: Colors.cyan.withOpacity(0.1),
                                        souraNameColor:Colors.white ,
                                        souraNameWeight: FontWeight.bold,
                                        souraNumColor: Colors.white,
                                        souraNumWeight: FontWeight.bold,
                                        bottomPadding: size.height * 0,
                                        leftPadding: size.width * 0.04,
                                        rightPadding: size.width * 0.04,
                                        topPadding: size.height * 0,
                                      ),
                                      onTap: ()
                                      {
                                        print(souraNum[index]);
                                        var numberOfSurah = int.parse(souraNum[index]);
                                        navigateTo(context, SouraScreen(
                                          numOfSoura: numberOfSurah,
                                          sourahName: quran.getSurahNameArabic(int.parse(souraNum[index])),
                                        ),
                                        );

                                      },
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context,index) => SizedBox(
                                width: size.width,
                                height: size.height * 0,
                              ),
                              itemCount: souraNum.length,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nakhtm/cubit/cubit.dart';
import 'package:nakhtm/cubit/states.dart';
import 'package:nakhtm/modules/soura_screen.dart';
import 'package:nakhtm/shared/components/constants.dart';
import '../shared/components/components.dart';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;



class MarkerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context , state) {},
        builder: (context , state)
        {
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
                          SizedBox(height: size.height * 0.11),
                          if (
                          constJuza != 0
                          )
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(size.width * 0.02),
                                    color: Colors.cyan,
                                  ),
                                  width: size.width,
                                  margin: EdgeInsets.fromLTRB(
                                      size.width * 0.02,
                                      0,
                                      size.width * 0.02,
                                      0
                                  ),
                                  child: ExpansionTile(
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'آخر ما قرأت:' ,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.05
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        size.width * 0.02,
                                        size.width * 0.02,
                                        size.width * 0.02,
                                        size.width * 0.02,
                                      ),
                                      child: Icon(
                                        Icons.arrow_drop_down, color: Colors.white, size: size.width * 0.05,
                                      ),
                                    ),
                                    children: [
                                      Column(
                                        children: [
                                          ListTile(
                                            title: Container(
                                              height: size.height * 0.0001,
                                              width: size.width,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    // AppCubit.get(context).sharedSurahName,
                                                    constSurahName,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: size.width * 0.06
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: size.width * 0.02,),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'سورة' ,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: size.width * 0.05
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Container(
                                              height: size.height * 0.0001,
                                              width: size.width,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    // AppCubit.get(context).sharedAyah,
                                                    constAyah,
                                                    textAlign: TextAlign.left,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: size.width * 0.06
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: size.width * 0.02,),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'ايه' ,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: size.width * 0.05
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Container(
                                              height: size.height * 0.0001,
                                              width: size.width,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    // '${AppCubit.get(context).sharedAyahNum}',
                                                    '$constAyahNum' ,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: size.width * 0.06
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: size.width * 0.02,),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'رقم الآيه' ,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: size.width * 0.05
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Container(
                                              height: size.height * 0.0001,
                                              width: size.width,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    // '${AppCubit.get(context).sharedJuza}' ,
                                                    '$constJuza',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: size.width * 0.06
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: size.width * 0.02,),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'الجزء' ,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: size.width * 0.05
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Container(
                                              height: size.height * 0.0001,
                                              width: size.width,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ListTile(
                                            title: TextButton(
                                                onPressed: ()
                                                {
                                                  navigateTo(context, SouraScreen(
                                                    numOfSoura: constSurahNum,
                                                    sourahName: quran.getSurahNameArabic(constSurahNum),
                                                  ),
                                                  );
                                                },
                                                child: Text(
                                                  'اضغط لتكملة القراءة' ,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: size.width * 0.06
                                                  ),
                                                )
                                            ),

                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.height * 0.05),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      size.width * 0.01,
                                      size.width * 0.02,
                                      size.width * 0.01,
                                      size.width * 0.02
                                  ),
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(size.width * 0.02),
                                        //color: Colors.purple
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight,
                                            colors: [Colors.purple , Colors.blue]
                                        )
                                    ),
                                    margin: EdgeInsets.all(size.width * 0.05),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          size.width * 0.05,
                                          size.width * 0.15,
                                          size.width * 0.05,
                                          size.width * 0.15
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${constJuza/30 * 100}%',

                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: size.width * 0.04,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'معدل الختمة (للمره الواحدة)',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: size.width * 0.04,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: size.height* 0.02,),
                                          LinearProgressIndicator(
                                            value: constJuza/30,
                                            color: Colors.white,
                                            backgroundColor: Colors.grey.shade700,
                                            minHeight: size.height * 0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.05),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(size.width * 0.02),
                                    color: Colors.cyan,
                                  ),
                                  width: size.width,
                                  height: size.height * 0.2,
                                  margin: EdgeInsets.fromLTRB(
                                      size.width * 0.02,
                                      0,
                                      size.width * 0.02,
                                      0
                                  ),
                                  child: Center(
                                     child: Text(
                                        'لحفظ اخر ما قمت بقراءته اضغط ضغطتين ع الآيه بعد الانتهاء من القراءة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: size.width * 0.07,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                )
              ],
            ),
          );
        }
    );
  }
}

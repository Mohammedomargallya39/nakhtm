import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakhtm/modules/prayer_time.dart';
import 'home_screen.dart';
import 'quran_screen.dart';
import 'sebha.dart';

class LayoutScreen extends StatefulWidget {
   LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
   var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(size.width * 0.02),
        height: size.height * 0.11,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: size.width * 0.07,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(size.width * 0.02,),

        ),
        child: ListView.builder(
            itemCount: 4,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            itemBuilder: (context,index)
            {
              return Center(
                child: InkWell(
                  onTap: ()
                  {
                    setState(() {
                      currentIndex = index ;
                    });
                    //AppCubit.get(context).currentIndex = index;
                    //currentIndex = index;
                    //HepticFeedback.lightImpact();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index ==
                            //AppCubit.get(context).currentIndex
                            currentIndex
                            ?
                        size.width * 0.3 : size.width * 0.1,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              //AppCubit.get(context).currentIndex
                              ?
                          size.width * 0.32 : 0,
                          height: index == currentIndex
                              //AppCubit.get(context).currentIndex
                              ?
                          size.height * 0.07 : 0,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                //AppCubit.get(context).currentIndex
                                ?
                            Colors.cyan: Colors.transparent,
                            borderRadius: BorderRadius.circular(size.width * 0.05),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            //AppCubit.get(context).currentIndex
                            ?
                        size.width * 0.3 : size.width * 0.2,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      //AppCubit.get(context).currentIndex
                                      ?
                                  size.width * 0.13 : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == currentIndex
                                      //AppCubit.get(context).currentIndex
                                      ?
                                  1 : 0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == currentIndex
                                        //AppCubit.get(context).currentIndex
                                        ? indexText[index] : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      //AppCubit.get(context).currentIndex
                                      ?
                                  size.width * 0.04: size.width * 0.03,
                                ),
                                Icon(
                                  indexIcon[index],
                                  size: size.width * 0.066,
                                  color: index == currentIndex
                                      //AppCubit.get(context).currentIndex
                                      ?
                                  Colors.white: Colors.black,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ) ;
            }

        ),
      ),
      body: screens[currentIndex],
    );
  }

  List<IconData> indexIcon =
  [
    Icons.home_outlined,
    Icons.menu_book_outlined,
    Icons.confirmation_number_outlined,
    Icons.access_time_outlined,
  ];

  List<String> indexText =
  [
    'الرئيسية',
    'القرآن',
    'سبحة',
    'مواعيد',
  ];
  List<Widget> screens =
  [
    HomeScreen(),
    QuranScreen(),
    SebhaScreen(),
    PrayerScreen(),
  ];
}


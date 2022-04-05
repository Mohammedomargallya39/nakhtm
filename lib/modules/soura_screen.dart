import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakhtm/shared/components/components.dart';
import 'package:nakhtm/shared/components/constants.dart';
import 'package:nakhtm/shared/network/local/cache_helper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

class SouraScreen extends StatefulWidget {
  SouraScreen({Key? key,required this.numOfSoura,required this.sourahName}) : super(key: key);
  final dynamic numOfSoura;
  final dynamic sourahName;
  final itemController = ItemScrollController();


  @override
  State<SouraScreen> createState() => _SouraScreen();
}

class _SouraScreen extends State<SouraScreen>{

  Future scrollToItem() async
  {
    widget.itemController.jumpTo(index:constAyahNum -1);
  }

  @override
  void initState() {
    super.initState();
    if(constAyahNum !=0) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => scrollToItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppStates>
      (
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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.03,
                        size.height * 0.02,
                        size.width * 0.03,
                        size.height * 0.02
                    ),
                    child:Column(
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
                            title: Text(
                              'معلومات عن السورة',
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
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
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${widget.sourahName}' ,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03,),
                                        Expanded(
                                          child: Text(
                                            'اسم السورة' ,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05,
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
                                            '${quran.getVerseCount(widget.numOfSoura)}' ,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03,),
                                        Expanded(
                                          child: Text(
                                            'عدد آيات السورة' ,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05,
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
                                            quran.getPlaceOfRevelation(widget.numOfSoura) ,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03,),
                                        Expanded(
                                          child: Text(
                                            'مكان نزول اسورة' ,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05,
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
                                            '${quran.getJuzNumber(widget.numOfSoura, 1)}' ,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03,),
                                        Expanded(
                                          child: Text(
                                            'الجزء' ,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05,
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
                                          child: SelectableText(
                                            quran.getSurahURL(widget.numOfSoura),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.04
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03,),
                                        Expanded(
                                          child: Text(
                                            'لينك السورة' ,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.05,
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
                        SizedBox(height: size.height * 0.03,),
                        if (widget.numOfSoura != 1 && widget.numOfSoura != 9)
                          Container(
                            width: size.width ,
                            margin: EdgeInsets.fromLTRB(
                                size.width * 0.21,
                                size.width * 0,
                                size.width * 0.12,
                                size.width * 0.0
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              gradient:  const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.1,
                                  size.width * 0.03,
                                  size.width * 0.1,
                                  size.width * 0.03
                              ),
                              child: SelectableText(
                                quran.basmala,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05,
                                  color: Colors.white,
                                  //Colors.white
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: size.height * 0.03,),





                        Expanded(
                          flex:  20,
                          child: ScrollablePositionedList.separated(
                              physics: const BouncingScrollPhysics(),
                              itemScrollController: widget.itemController,
                              separatorBuilder: (context,index)
                              {
                                return Container(
                                  height: size.height * 0.02,
                                  width: size.width,
                                );
                              },
                              itemCount: quran.getVerseCount(widget.numOfSoura),
                              itemBuilder: (context,index)
                              {
                                AppCubit.get(context).juza = quran.getJuzNumber(widget.numOfSoura, index + 1);
                                return ListTile(
                                  title: InkWell(
                                    onDoubleTap: ()
                                    {
                                      AppCubit.get(context).lastRead();
                                      AppCubit.get(context).juza = quran.getJuzNumber(widget.numOfSoura, index + 1);
                                      AppCubit.get(context).surahName = widget.sourahName;
                                      AppCubit.get(context).ayah = (quran.getVerse(widget.numOfSoura, index + 1,));
                                      AppCubit.get(context).ayahNum = index + 1;
                                      AppCubit.get(context).surahNum = widget.numOfSoura;
                                      AppCubit.get(context).ayatSurahNum = quran.getVerseCount(widget.numOfSoura);

                                      print(constAyah);
                                      print(constJuza);
                                      print(constAyahNum);
                                      print(constSurahName);
                                      print(constSurahNum);

                                      CacheHelper.saveData(key: 'juza', value: AppCubit.get(context).juza);
                                      CacheHelper.saveData(key: 'surahName', value: AppCubit.get(context).surahName);
                                      CacheHelper.saveData(key: 'ayah', value: AppCubit.get(context).ayah);
                                      CacheHelper.saveData(key: 'ayahNum', value: AppCubit.get(context).ayahNum);
                                      CacheHelper.saveData(key: 'surahNum', value: AppCubit.get(context).surahNum);
                                      CacheHelper.saveData(key: 'ayatSurahNum', value: AppCubit.get(context).ayatSurahNum);

                                      showToast(message: 'تم حفظ آخر ما قرأت بنجاح', state: ToastStates.SUCCESS);

                                    },

                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                                width: size.width,
                                                height: size.height * 0.04,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(11),
                                                  gradient: const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                                                    // [Colors.blue.shade300 , Colors.green.shade200.withOpacity(0.8)]
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                      '${index + 1}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: size.width * 0.04,
                                                          color: Colors.white
                                                      ),
                                                    )
                                                ),
                                              )
                                          ),
                                          SizedBox(width: size.width * 0.02,),
                                          Expanded(
                                            flex: 10,
                                            child: Container(
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(11),
                                                  gradient:  const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                                                  )
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    size.width * 0.04,
                                                    size.width * 0.04,
                                                    size.width * 0.04,
                                                    size.width * 0.04
                                                ),
                                                child: SelectableText(
                                                  quran.getVerse(
                                                    widget.numOfSoura,
                                                    index + 1,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: size.width * 0.05,
                                                    color: Colors.white,
                                                    //Colors.white
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(width: size.width * 0.02,),
                                          // Expanded(
                                          //     child: Container(
                                          //       width: size.width,
                                          //       height: size.height * 0.04,
                                          //       decoration: BoxDecoration(
                                          //         borderRadius: BorderRadius.circular(11),
                                          //         gradient: const LinearGradient(
                                          //             begin: Alignment.topLeft,
                                          //             end: Alignment.bottomRight,
                                          //             colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                                          //           // [Colors.blue.shade300 , Colors.green.shade200.withOpacity(0.8)]
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //           child: Text(
                                          //             '${AppCubit.get(context).juza}',
                                          //             style: TextStyle(
                                          //                 fontWeight: FontWeight.bold,
                                          //                 fontSize: size.width * 0.04,
                                          //                 color: Colors.white
                                          //             ),
                                          //           )
                                          //       ),
                                          //     )
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),

                        ),

                        // Expanded(
                        //   flex:  20,
                        //   child: ListView.separated(
                        //       physics: const BouncingScrollPhysics(),
                        //       separatorBuilder: (context,index)
                        //       {
                        //         return Container(
                        //           height: size.height * 0.02,
                        //           width: size.width,
                        //         );
                        //       },
                        //       itemCount: quran.getVerseCount(numOfSoura),
                        //       itemBuilder: (context,index)
                        //       {
                        //         AppCubit.get(context).juza = quran.getJuzNumber(numOfSoura, index + 1);
                        //         return ListTile(
                        //           title: InkWell(
                        //             onDoubleTap: ()
                        //             {
                        //               AppCubit.get(context).lastRead();
                        //               AppCubit.get(context).juza = quran.getJuzNumber(numOfSoura, index + 1);
                        //               AppCubit.get(context).surahName = sourahName;
                        //               AppCubit.get(context).ayah = (quran.getVerse(numOfSoura, index + 1,));
                        //               AppCubit.get(context).ayahNum = index + 1;
                        //               AppCubit.get(context).surahNum = numOfSoura;
                        //               AppCubit.get(context).ayatSurahNum = quran.getVerseCount(numOfSoura);
                        //
                        //               print(constAyah);
                        //               print(constJuza);
                        //               print(constAyahNum);
                        //               print(constSurahName);
                        //               print(constSurahNum);
                        //
                        //               CacheHelper.saveData(key: 'juza', value: AppCubit.get(context).juza);
                        //               CacheHelper.saveData(key: 'surahName', value: AppCubit.get(context).surahName);
                        //               CacheHelper.saveData(key: 'ayah', value: AppCubit.get(context).ayah);
                        //               CacheHelper.saveData(key: 'ayahNum', value: AppCubit.get(context).ayahNum);
                        //               CacheHelper.saveData(key: 'surahNum', value: AppCubit.get(context).surahNum);
                        //               CacheHelper.saveData(key: 'ayatSurahNum', value: AppCubit.get(context).ayatSurahNum);
                        //
                        //               showToast(message: 'تم حفظ آخر ما قرأت بنجاح', state: ToastStates.SUCCESS);
                        //
                        //             },
                        //             child: Container(
                        //               child: Row(
                        //                 children: [
                        //                   Expanded(
                        //                       child: Container(
                        //                         width: size.width,
                        //                         height: size.height * 0.04,
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.circular(11),
                        //                           gradient: const LinearGradient(
                        //                               begin: Alignment.topLeft,
                        //                               end: Alignment.bottomRight,
                        //                               colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                        //                             // [Colors.blue.shade300 , Colors.green.shade200.withOpacity(0.8)]
                        //                           ),
                        //                         ),
                        //                         child: Center(
                        //                             child: Text(
                        //                               '${index + 1}',
                        //                               style: TextStyle(
                        //                                   fontWeight: FontWeight.bold,
                        //                                   fontSize: size.width * 0.04,
                        //                                   color: Colors.white
                        //                               ),
                        //                             )
                        //                         ),
                        //                       )
                        //                   ),
                        //                   SizedBox(width: size.width * 0.02,),
                        //                   Expanded(
                        //                     flex: 10,
                        //                     child: Container(
                        //                       width: size.width,
                        //                       decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.circular(11),
                        //                           gradient:  const LinearGradient(
                        //                               begin: Alignment.topLeft,
                        //                               end: Alignment.bottomRight,
                        //                               colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                        //                           )
                        //                       ),
                        //                       child: Padding(
                        //                         padding: EdgeInsets.fromLTRB(
                        //                             size.width * 0.04,
                        //                             size.width * 0.04,
                        //                             size.width * 0.04,
                        //                             size.width * 0.04
                        //                         ),
                        //                         child: SelectableText(
                        //                           quran.getVerse(
                        //                             numOfSoura,
                        //                             index + 1,
                        //                           ),
                        //                           textAlign: TextAlign.center,
                        //                           style: TextStyle(
                        //                             fontWeight: FontWeight.bold,
                        //                             fontSize: size.width * 0.05,
                        //                             color: Colors.white,
                        //                             //Colors.white
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   // SizedBox(width: size.width * 0.02,),
                        //                   // Expanded(
                        //                   //     child: Container(
                        //                   //       width: size.width,
                        //                   //       height: size.height * 0.04,
                        //                   //       decoration: BoxDecoration(
                        //                   //         borderRadius: BorderRadius.circular(11),
                        //                   //         gradient: const LinearGradient(
                        //                   //             begin: Alignment.topLeft,
                        //                   //             end: Alignment.bottomRight,
                        //                   //             colors: [Color.fromARGB(255, 83, 183, 214) , Color.fromARGB(255, 134, 231, 214)]
                        //                   //           // [Colors.blue.shade300 , Colors.green.shade200.withOpacity(0.8)]
                        //                   //         ),
                        //                   //       ),
                        //                   //       child: Center(
                        //                   //           child: Text(
                        //                   //             '${AppCubit.get(context).juza}',
                        //                   //             style: TextStyle(
                        //                   //                 fontWeight: FontWeight.bold,
                        //                   //                 fontSize: size.width * 0.04,
                        //                   //                 color: Colors.white
                        //                   //             ),
                        //                   //           )
                        //                   //       ),
                        //                   //     )
                        //                   // ),
                        //
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         );
                        //       }
                        //   ),
                        //
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}

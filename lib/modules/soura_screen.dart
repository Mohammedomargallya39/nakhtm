import 'dart:ui';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;


class SouraScreen extends StatelessWidget {
  const SouraScreen({Key? key,required this.numOfSoura}) : super(key: key);
  final dynamic numOfSoura;
 // final int number;
  @override
  Widget build(BuildContext context) {
    int numberOfAyah = 1;
    int indexAyah = numberOfAyah + 1;
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
                            if (numOfSoura != 1 && numOfSoura != 9)
                            Expanded(
                                child: Text(
                                  'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04
                                  ),
                                ),
                              ),
                            Expanded(
                              flex:  24,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context,index)
                                  {
                                    return Container(
                                      height: size.height * 0.02,
                                      width: size.width,
                                    );
                                  },
                                  itemCount: quran.getVerseCount(numOfSoura),
                                  itemBuilder: (context,index)
                                  {
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                                width: size.width,
                                                height: size.height * 0.04,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(11),
                                                  gradient:  const LinearGradient(
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
                                                child: Text(
                                                  quran.getVerse(
                                                    numOfSoura,
                                                    index + 1,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: size.width * 0.05,
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              ),
                            ),
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

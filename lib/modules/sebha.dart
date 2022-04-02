import 'package:flutter/material.dart';
import 'package:nakhtm/cubit/cubit.dart';
import 'package:nakhtm/cubit/states.dart';
import '../shared/components/components.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SebhaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      'سبحة',
                      style: TextStyle(
                        fontSize: size.width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                      ),
                      child: InkWell(
                        onTap: ()
                        {
                          AppCubit.get(context).sebha();
                          AppCubit.get(context).countSubhanAllah ++ ;
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0
                              ),
                              child: Center(
                                child: Text(
                                  'سبحان الله',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0.02
                              ),
                              child: Center(
                                child: Text(
                                  '${AppCubit.get(context).countSubhanAllah}',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                      ),
                      child: InkWell(
                        onTap: ()
                        {
                          AppCubit.get(context).sebha();
                          AppCubit.get(context).countAlhamdullah ++ ;
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0
                              ),
                              child: Center(
                                child: Text(
                                  'الحمد الله',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0.02
                              ),
                              child: Center(
                                child: Text(
                                  '${AppCubit.get(context).countAlhamdullah}',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                      ),
                      child: InkWell(
                        onTap: ()
                        {
                          AppCubit.get(context).sebha();
                          AppCubit.get(context).countAllahAkbar ++ ;
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0
                              ),
                              child: Center(
                                child: Text(
                                  ' الله أكبر',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0.02
                              ),
                              child: Center(
                                child: Text(
                                  '${AppCubit.get(context).countAllahAkbar}',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                      ),
                      child: InkWell(
                        onTap: ()
                        {
                          AppCubit.get(context).sebha();
                          AppCubit.get(context).countLaElahElaAllah ++ ;
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0
                              ),
                              child: Center(
                                child: Text(
                                  'لا إله إلا الله وحده لا شريك له له المك وله الحمد و هو علي كل شئ قدير',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: size.width * 0.066,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0.02
                              ),
                              child: Center(
                                child: Text(
                                  '${AppCubit.get(context).countLaElahElaAllah}',
                                  style: TextStyle(
                                      fontSize: size.width * 0.1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        );
      }
    );
  }
}

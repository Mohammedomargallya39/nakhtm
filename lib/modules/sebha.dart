import 'package:flutter/material.dart';
import 'package:nakhtm/cubit/cubit.dart';
import 'package:nakhtm/cubit/states.dart';
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
                        //   'assets/images/3.svg',
                        //   height: size.height * 0.3,
                        //   width: size.width,
                        // ),
                        Image.asset(
                          'assets/images/5.png',
                          height: size.height * 0.3,
                          width: size.width,
                        ),
                        SizedBox(height: size.height * 0.04,),
                        Container(
                          margin: EdgeInsets.all(size.width * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.cyan.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(size.width * 0.05),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'سبحة',
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
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
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            'سبحان الله',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
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
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            'الحمد الله',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
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
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            ' الله أكبر',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
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
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            'لا إله إلا الله وحده لا شريك له له المك وله الحمد و هو علي كل شئ قدير',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
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

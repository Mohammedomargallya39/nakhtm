import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';
import 'package:location/location.dart';
import '../../controller/state.dart';
import '../tasbeeh/tasbeeh_screen.dart';
import 'ahadeth_screen.dart';
import 'elsalah_time_screen.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  Stream<int> counterStream = Stream.periodic(const Duration(seconds: 20), (int i) => i);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(
              Assets.images.png.appBackground,
          ),
            fit: BoxFit.cover
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: designApp,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultText(
                    title: AppString.appName,
                    style: Style.medium,
                    fontWeight: FontWeight.w600,
                    fontSize: 25.rSp,
                    fontFamily: 'arabic',
                  ),
                  verticalSpace(2.h,),
                  SvgPicture.asset(Assets.images.svg.icon),
                  verticalSpace(2.h,),
                  Row(
                    children: [
                      BlocBuilder<HomeCubit,HomeState>(
                        builder: (context, state) {
                          return BlocBuilder<AppBloc,AppState>(
                            builder: (context, state) {
                              return Expanded(
                                child: InkWell(
                                  onTap: () async{
                                    {
                                      Location location = Location();
                                      PermissionStatus permissionStatus = await location.requestPermission();
                                      if(permissionStatus == PermissionStatus.granted)
                                      {
                                        homeCubit.getLocation();
                                        navigateTo(context, const ElsalahTimeScreen());
                                        if(appBloc.isAppConnected == false)
                                        {
                                          designToastDialog(
                                              context: context,
                                              toast: TOAST.warning,
                                              text: 'برجاء فتح الانترنت لتحديث الأوقات'
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    Assets.images.svg.elsalahTimeButton,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      horizontalSpace(5.w),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            navigateTo(context, const TasbeehScreen());
                          },
                          child: SvgPicture.asset(Assets.images.svg.tasbeh),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(2.h,),
                  InkWell(
                    onTap: (){
                      navigateTo(context, const AhadethScreen());
                    },
                    child: Center(
                        child: SvgPicture.asset(
                            Assets.images.svg.ahadeth)),
                  ),
                  verticalSpace(2.h,),
                  Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SvgPicture.asset(Assets.images.svg.slah),
                        StreamBuilder(
                            stream: counterStream,
                            builder: (context, snapshot) {
                              homeCubit.pickRandomHomeSlah();
                              return Padding(
                                padding: EdgeInsets.fromLTRB(20.rSp, 40.rSp, 20.rSp,0),
                                child: DefaultText(
                                  align: TextAlign.center,
                                  title: homeCubit.pickedRandom!,
                                  style: Style.medium,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.white,
                                  fontSize: 16.rSp,
                                ),
                              );
                            },
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
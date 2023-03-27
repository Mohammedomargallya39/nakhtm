import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_app_bar.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';
import '../../controller/state.dart';
import '../../widgets/azkar_view_build_item.dart';

class AzkarViewWidget extends StatelessWidget {
   AzkarViewWidget({Key? key,required this.azkarIndex}) : super(key: key);

  int azkarIndex;

  @override
  Widget build(BuildContext context) {
    int? pressedIndex;
    List<String> appBarBackground = [
      Assets.images.svg.morningAzkarAppBar,
      Assets.images.svg.eveningAzkarAppBar,
      Assets.images.svg.elmasgedAzkarAppBar,
      Assets.images.svg.elnoomAzkarAppBar,
      Assets.images.svg.elsalahAzkarAppBar,
    ];
    List<Color> azkarColor = [
      ColorsManager.orangePrimary,
      ColorsManager.mainCard,
      ColorsManager.mainColor,
      ColorsManager.purple,
      ColorsManager.lightBrown,
    ];

    HomeCubit homeCubit = HomeCubit.get(context);

    if(!homeCubit.ended){
      homeCubit.initializeLists();
      homeCubit.initializeRepetition();
    }


      return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            appBarBackground: appBarBackground[azkarIndex],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                Assets.images.png.appBackground,
              ),
                  fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: designApp,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => InkWell(
                        onTap: (){
                          pressedIndex = index;
                          if(azkarIndex == 0 )
                          {
                            homeCubit.changeRepetitionMorinigNum(index);
                            if(homeCubit.repetitionMorningNum![index] == 0  && homeCubit.azkarMorning!.isNotEmpty){
                              homeCubit.azkarMorning!.removeAt(index);
                              homeCubit.repetitionMorningNum!.removeAt(index);
                            }else{
                              homeCubit.ended = true;
                            }
                          }
                          if(azkarIndex == 1 )
                          {
                            homeCubit.changeRepetitionEveningNum(index);
                            if(homeCubit.repetitionEveningNum![index] == 0  && homeCubit.azkarEvening!.isNotEmpty){
                              homeCubit.azkarEvening!.removeAt(index);
                              homeCubit.repetitionEveningNum!.removeAt(index);
                            }else{
                              homeCubit.ended = true;

                            }
                          }
                          if(azkarIndex == 2 )
                          {
                            homeCubit.changeRepetitionMasgedNum(index);
                            if(homeCubit.repetitionMasgedNum![index] == 0 && homeCubit.azkarMasged!.isNotEmpty){
                              homeCubit.azkarMasged!.removeAt(index);
                              homeCubit.repetitionMasgedNum!.removeAt(index);
                            }
                            else{
                              homeCubit.ended = true;

                            }
                          }
                          if(azkarIndex == 3 )
                          {
                            homeCubit.changeRepetitionSleepingNum(index);
                            if(homeCubit.repetitionSleepingNum![index] == 0  && homeCubit.azkarSleeping!.isNotEmpty){
                              homeCubit.azkarSleeping!.removeAt(index);
                              homeCubit.repetitionSleepingNum!.removeAt(index);
                            }else{
                              homeCubit.ended = true;

                            }
                          }
                          if(azkarIndex == 4 )
                          {
                            homeCubit.changeRepetitionElsalahNum(index);
                            if(homeCubit.repetitionElsalahNum![index] == 0  && homeCubit.azkarElsalah!.isNotEmpty){
                              homeCubit.azkarElsalah!.removeAt(index);
                              homeCubit.repetitionElsalahNum!.removeAt(index);
                            }else{
                              homeCubit.ended = true;
                            }
                          }

                        },
                        child: AzkarViewBuildItem(
                          repetitionNum: azkarIndex ==0 ? homeCubit.repetitionMorningNum![index] : azkarIndex == 1 ? homeCubit.repetitionEveningNum![index]: azkarIndex == 4 ? homeCubit.repetitionElsalahNum![index] : azkarIndex == 3 ? homeCubit.repetitionSleepingNum![index] : homeCubit.repetitionMasgedNum![index],
                          azkar: azkarIndex ==0 ? homeCubit.azkarMorning![index] :  azkarIndex == 1 ? homeCubit.azkarEvening![index]:  azkarIndex == 4 ? homeCubit.azkarElsalah![index] : azkarIndex == 3 ? homeCubit.azkarSleeping![index]: homeCubit.azkarMasged![index],
                          azkarColor:azkarColor[azkarIndex],
                        ),
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount:azkarIndex ==0 ? homeCubit.azkarMorning!.length : azkarIndex == 1 ? homeCubit.azkarEvening!.length : azkarIndex == 4 ? homeCubit.azkarElsalah!.length : azkarIndex == 3 ? homeCubit.azkarSleeping!.length : homeCubit.azkarMasged!.length,
                    ),
                  ),
                  if(homeCubit.ended)
                  OutlinedButton(onPressed: (){
                    homeCubit.initializeRepetition();
                    homeCubit.initializeLists();
                    homeCubit.ended = false;
                  }, child: const DefaultText(
                    title: 'هل تريد اعادة قراءة الاذكار؟',
                    style: Style.extraSmall,
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
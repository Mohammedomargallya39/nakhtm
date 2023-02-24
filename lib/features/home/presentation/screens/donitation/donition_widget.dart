import 'package:flutter/cupertino.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/bloc.dart';

class SadakaWidget extends StatelessWidget {
  const SadakaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return SafeArea(
        child: Center(
          child: Padding(
            padding: designApp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                    title: 'صدقة جارية',
                    style: Style.large,
                    fontSize: 30.rSp,
                    fontWeight: FontWeight.w600,
                ),
                verticalSpace(5.h),
                DefaultText(
                  align: TextAlign.center,
                  title: 'شارك التطبيق لمن تعرف ليصبح صدقة جارية لنا و لك',
                  style: Style.medium,
                  fontSize: 18.rSp,
                  fontWeight: FontWeight.w600,
                ),
                verticalSpace(10.h),
                myButton(
                    text: 'إضغط للمشاركة',
                    onPressed: ()
                    {
                      homeCubit.share();
                    },
                )
              ],
            ),
          ),
        )
    );
  }
}

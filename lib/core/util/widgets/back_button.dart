import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../resources/assets.gen.dart';
import '../resources/colors_manager.dart';


class DefaultBackButton extends StatelessWidget {
   const DefaultBackButton({Key? key,required this.function}) : super(key: key);



  final VoidCallback function;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:function,
      child: SvgPicture.asset(Assets.images.svg.arrowBack,color: ColorsManager.white,)
    );
  }
}

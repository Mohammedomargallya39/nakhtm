import 'package:flutter/material.dart';
import 'package:nakhtm/core/util/resources/appString.dart';
import 'package:nakhtm/core/util/resources/colors_manager.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    required this.onChange,
    this.color,
    this.size,
    this.fontSize,
    this.border,
    this.enabled = true,
    this.onTap,
    this.controller,
    Key? key,
  }) : super(key: key);

  final Function(String) onChange;
  final Color? color;
  final double? size;
  final double? fontSize;
  final double? border;
  final VoidCallback? onTap;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.rSp),
      child: Container(
        decoration: BoxDecoration(
          color: color ?? ColorsManager.mainCard.withOpacity(0.3),
          borderRadius: BorderRadius.circular(border ?? 10.rSp),
        ),
        child: TextFormField(
          onChanged: onChange,
          onTap: onTap,
          controller: controller,
          textInputAction: TextInputAction.search,
          cursorColor: ColorsManager.white,
          enabled: enabled,
          style: const TextStyle(
            color: ColorsManager.white
          ),
          decoration: InputDecoration(
            hintText: AppString.search,
            hintStyle: TextStyle(
              fontSize: fontSize,
              color: ColorsManager.white,
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: ColorsManager.white,
              size: size,
            ),
          ),
        ),
      ),
    );
  }
}

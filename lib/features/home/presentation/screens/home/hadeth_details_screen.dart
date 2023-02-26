import 'package:flutter/material.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/widgets/default_app_bar.dart';
import '../../controller/bloc.dart';
import 'hadeth_details_widget.dart';

class HadethDetailScreen extends StatelessWidget {
  HadethDetailScreen({Key? key, required this.title, required this.bookName}) : super(key: key);

  String title;
  String bookName;

  @override
  Widget build(BuildContext context) {

    HomeCubit homeCubit = HomeCubit.get(context);
    return Scaffold(
      appBar: defaultAppBar(
          context: context,
          appBarBackground: Assets.images.svg.appbar_hadeth_details,
          title: title,
          onTap: ()
          {
            homeCubit.pageNumber = 1;
            Navigator.pop(context);
          }
      ),
      body: HadethDetailsWidget(
        title: title,
        bookName: bookName,
      ),
    );
  }
}

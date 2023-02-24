import 'package:flutter/material.dart';
import 'hadeth_details_widget.dart';

class HadethDetailScreen extends StatelessWidget {
  HadethDetailScreen({Key? key, required this.title, required this.bookName}) : super(key: key);

  String title;
  String bookName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HadethDetailsWidget(
        title: title,
        bookName: bookName,
      ),
    );
  }
}

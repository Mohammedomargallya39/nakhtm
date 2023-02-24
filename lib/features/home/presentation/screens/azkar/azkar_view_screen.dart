import 'package:flutter/material.dart';
import 'azkar_view_widget.dart';

class AzkarViewScreen extends StatelessWidget {
  AzkarViewScreen({Key? key, required this.azkarIndex}) : super(key: key);
  int azkarIndex;

  @override
  Widget build(BuildContext context) {
    return AzkarViewWidget(azkarIndex: azkarIndex,);
  }
}

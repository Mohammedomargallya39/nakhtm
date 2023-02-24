import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'azkar_widget.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    return const AzkarWidget();
  }
}

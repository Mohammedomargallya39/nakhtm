import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'donition_widget.dart';

class SadakaScreen extends StatelessWidget {
  const SadakaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    return const Scaffold(
      body: SadakaWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    return Scaffold(
      body: HomeWidget(),
    );
  }
}

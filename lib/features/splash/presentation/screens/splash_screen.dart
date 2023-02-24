import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../home/presentation/screens/main_screen.dart';
import '../widgets/splash_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2),() {
        navigateAndFinish(context,const MainScreen());
      });
    });

    return const Scaffold(
        body: SplashWidget()
    );
  }
}

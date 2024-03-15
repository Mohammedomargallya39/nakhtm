import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nakhtm/features/home/presentation/screens/quran/surah_widget.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({Key? key, required this.surahNum}) : super(key: key);

  final int surahNum;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    return SurahWidget(surahNumber: surahNum,);
  }
}

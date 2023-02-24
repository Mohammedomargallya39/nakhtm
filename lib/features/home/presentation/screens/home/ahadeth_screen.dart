import 'package:flutter/material.dart';

import 'ahadeth_widget.dart';

class AhadethScreen extends StatelessWidget {
  const AhadethScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AhadethWidget(),
    );
  }
}

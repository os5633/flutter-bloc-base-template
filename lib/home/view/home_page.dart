import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_template/common/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HomePage(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      child: Center(child: Text("Bloc기반의 Flutter 템플릿 입니다")),
    );
  }
}

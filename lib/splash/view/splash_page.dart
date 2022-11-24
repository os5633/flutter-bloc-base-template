import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_template/common/common.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SplashPage(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      child: Center(child: Text("splash")),
    );
  }
}

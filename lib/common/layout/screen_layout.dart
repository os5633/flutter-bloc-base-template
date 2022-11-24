import 'package:flutter/material.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({
    Key? key,
    required this.child,
    this.appBar,
    this.padding,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);
  final PreferredSizeWidget? appBar;
  final Widget child;
  final EdgeInsets? padding;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  get appBar => widget.appBar;
  get padding => widget.padding;
  get child => widget.child;
  get bottomNavigationBar => widget.bottomNavigationBar;
  get bottomSheet => widget.bottomSheet;
  get floatingActionButton => widget.floatingActionButton;
  get floatingActionButtonLocation => widget.floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomSheet: bottomSheet,
      backgroundColor: Colors.black,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.endDocked,
      floatingActionButton: floatingActionButton,
      body: Container(
        padding: padding,
        child: child,
      ),
    );
  }
}

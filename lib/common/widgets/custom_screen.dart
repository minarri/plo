import 'package:flutter/material.dart';

class CustomInitialScreen extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsets padding;
  const CustomInitialScreen(
      {Key? key, this.appBar, required this.body, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: padding,
                child: body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

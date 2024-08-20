import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DefaultButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  // final Color? color;
  final Color? textColor;
  // final double height;
  const DefaultButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    // this.color = WidgetStyleConstants.defaultButtonColor,
    this.textColor = Colors.white,
    // final this.height = WidgetStyleConstants.loginButtonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      onTap: () => onPressed(),
      child: Container(
        height: 44.0,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: FittedBox(
            child: Text(text, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor)),
          ),
        ),
      ),
    );
  }
}

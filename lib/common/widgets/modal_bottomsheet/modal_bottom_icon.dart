import 'package:flutter/material.dart';

class ModalBottomSheetIcon extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Function onTap;

  const ModalBottomSheetIcon(
      {super.key, required this.title, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Row(
            children: [
              if (icon != null)
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                    child: icon!),
              const SizedBox(width: 20),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

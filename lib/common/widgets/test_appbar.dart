import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isZeroHeight;
  final Color? backgroundColor;
  final Widget? actionIcon;
  final Function()? actionIconOnTap;
  const TestAppbarWidget(
      {this.title,
      this.backgroundColor,
      this.isZeroHeight = false,
      super.key,
      this.actionIcon,
      this.actionIconOnTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: isZeroHeight ? 0 : null,
        centerTitle: true,
        title: title != null
            ? FittedBox(
                child:
                    Text(title!, style: Theme.of(context).textTheme.titleLarge),
              )
            : null,
        elevation: 0,
        actions: [
          if (actionIcon != null)
            InkWell(
              onTap: actionIconOnTap,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 25,
                        maxWidth: 25,
                      ),
                      child: actionIcon)),
            )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black));
  }
}

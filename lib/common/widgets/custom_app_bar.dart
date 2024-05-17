import 'package:flutter/material.dart';

//Appbar with backbutton
class BackButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackButtonAppBar({this.title, super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: BackButton(
        color: const Color(0xFF000000),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title ?? "",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

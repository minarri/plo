import 'package:flutter/material.dart';
import 'package:plo/views/home_screen/home_screen.dart';

//Appbar with backbutton
class BackButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackButtonAppBar({this.title, super.key}) : preferredSize = const Size.fromHeight(kToolbarHeight);

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

class HomeButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeButtonAppBar({this.title, super.key}) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        color: const Color(0xFF000000),
        icon: const Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
      ),
      title: Text(
        title ?? "",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

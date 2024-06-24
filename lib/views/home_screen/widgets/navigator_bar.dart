import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  const NavigationBarWidget({super.key, required this.selectedIndex, required this.onTabChange});
  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidget();
}

class _NavigationBarWidget extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.black,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          selectedIndex: widget.selectedIndex,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white, 
          tabBackgroundColor: Colors.grey,
          gap: 8,
          onTabChange: widget.onTabChange,
          padding:  const EdgeInsets.all(16),
          tabs: [
          const GButton(
            icon: (Icons.home), text: "홈",
          ),
          const GButton(
            icon: (Icons.search), text: "검색",
          ),
          const GButton(
            icon: (Icons.notifications), text: "알람",
          ),
          const GButton(
            icon: (Icons.person), text: "프로필",
          ),
        ]),
      ),
    );
  }
}

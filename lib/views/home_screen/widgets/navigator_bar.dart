import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  const NavigationBarWidget(
      {super.key, required this.selectedIndex, required this.onTabChange});
  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidget();
}

class _NavigationBarWidget extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return GNav(
        selectedIndex: widget.selectedIndex,
        backgroundColor: Colors.transparent,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.grey,
        gap: 4,
        onTabChange: widget.onTabChange,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        textSize: 10,
        iconSize: 22,
        tabs: [
          const GButton(
            icon: (Icons.home),
            text: "홈",
          ),
          const GButton(
            icon: (Icons.search),
            text: "검색",
          ),
          const GButton(
            icon: (Icons.notifications),
            text: "알람",
          ),
          const GButton(
            icon: (Icons.person),
            text: "프로필",
          ),
        ]);
  }
}
// import 'package:flutter/material.dart';

// class NavigationBarWidget extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTabChange;
//   const NavigationBarWidget(
//       {super.key, required this.selectedIndex, required this.onTabChange});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       height: 60, // Adjust height as needed
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.home,
//                 color: selectedIndex == 0 ? Colors.grey : Colors.white),
//             onPressed: () => onTabChange(0),
//           ),
//           IconButton(
//             icon: Icon(Icons.search,
//                 color: selectedIndex == 1 ? Colors.grey : Colors.white),
//             onPressed: () => onTabChange(1),
//           ),
//           SizedBox(width: 40), // Space for the Floating Action Button
//           IconButton(
//             icon: Icon(Icons.notifications,
//                 color: selectedIndex == 2 ? Colors.grey : Colors.white),
//             onPressed: () => onTabChange(2),
//           ),
//           IconButton(
//             icon: Icon(Icons.person,
//                 color: selectedIndex == 3 ? Colors.grey : Colors.white),
//             onPressed: () => onTabChange(3),
//           ),
//         ],
//       ),
//     );
//   }
// }

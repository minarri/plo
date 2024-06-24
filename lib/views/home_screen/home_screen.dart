// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:plo/common/widgets/custom_app_bar.dart';
// import 'package:plo/views/home_screen/widgets/mainpostlist.dart';
// import 'package:plo/views/post_write/post_write_screen/post_write_screen.dart';
// import 'package:plo/providers/login_verification_provider.dart';
// import 'package:plo/repository/firebase_auth_repository.dart';
// import 'package:plo/views/search_posts_screen/search_posts.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: BackButtonAppBar(),
//           child: Stack(children: [
//             Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 heroTag: "button1",
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20), side: const BorderSide()),
//                 onPressed: () async {
//                   if (ref.watch(logInVerifyProvider) == false) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("로그인을 해야 글을 작성 할 수 있습니다.")));
//                     return;
//                   }
//                   Navigator.of(context).push(
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation, secondaryAnimation) =>
//                           const CreateEditPostScreen(),
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                         var begin = const Offset(0, 1);
//                         var end = Offset.zero;
//                         var curve = Curves.easeIn;
//                         var between = Tween(begin: begin, end: end)
//                             .chain(CurveTween(curve: curve));

//                         return SlideTransition(
//                           position: animation.drive(between),
//                           child: child,
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Icon(
//                     Icons.home,
//                     color: Colors.black,
//                     size: 24.0,
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: FloatingActionButton(
//                 heroTag: "button2",
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return const SearchPosts();
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );

//     // body: const Column(
//     //   children: [
//     //     //Expanded(child: MainPostList()),
//     //   ],
//     // ),
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/views/home_screen/widgets/navigator_bar.dart';
import 'package:plo/views/post_write/post_write_screen/post_write_screen.dart';
import 'package:plo/views/search_posts_screen/search_posts.dart';
import 'package:plo/views/settings_screen/provider/non_login_provider.dart';
import 'package:plo/views/settings_screen/settings_screen.dart';
import 'package:plo/views/test_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }
  final List<Widget> pages = [
    const TestScreen(),
    const SearchPosts(),
    const TestScreen(),
    const TestScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BackButtonAppBar(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          physics: NeverScrollableScrollPhysics(),
          children: pages,
        ),
        bottomNavigationBar: NavigationBarWidget(
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
        ),
      ),
    );
  }
}
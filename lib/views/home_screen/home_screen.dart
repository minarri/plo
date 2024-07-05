import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/views/home_screen/widgets/mainpostlist.dart';
import 'package:plo/views/home_screen/widgets/navigator_bar.dart';
import 'package:plo/views/post_write/post_write_screen/post_write_screen.dart';
import 'package:plo/views/search_posts_screen/search_posts_main.dart';
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
    const MainPostList(),
    const SearchPostsMain(),
    const TestScreen(),
    const SettingsScreen()
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

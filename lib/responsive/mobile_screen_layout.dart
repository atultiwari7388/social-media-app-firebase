import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/utils/global_var.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _pages = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _pages = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: HomeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        selectedItemColor: Color(0xff00035B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: navigationTapped,
        currentIndex: _pages,
        selectedLabelStyle: GoogleFonts.laila(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _pages == 0 ? IconlyBold.home : IconlyLight.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _pages == 1 ? IconlyBold.search : IconlyLight.search,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _pages == 2 ? IconlyBold.moreCircle : IconlyLight.moreCircle,
            ),
            label: "Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _pages == 3 ? IconlyBold.heart : IconlyLight.heart,
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _pages == 4 ? IconlyBold.profile : IconlyLight.profile,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is mobile screen"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.home,
                color: Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.search,
                color: Colors.black,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.moreCircle,
                color: Colors.black,
              ),
              label: "Post"),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.heart,
                color: Colors.black,
              ),
              label: "Favorite"),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.profile,
              color: Colors.black,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

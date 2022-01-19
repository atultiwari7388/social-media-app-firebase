import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post.screen.dart';
import 'package:instagram_clone/screens/feed_ui.screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search.screen.dart';

const APPNAME = 'Inspire Bharat';

List<Widget> HomeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Favorites"),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
];

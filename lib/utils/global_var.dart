import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post.screen.dart';
import 'package:instagram_clone/screens/feed_ui.screen.dart';
import 'package:instagram_clone/screens/search.screen.dart';

const APPNAME = 'Inspire Bharat';

const HomeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Favorites"),
  Text("Profile"),
];

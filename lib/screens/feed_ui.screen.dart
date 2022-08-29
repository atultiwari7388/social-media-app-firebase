import 'dart:typed_data';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/screens/add_post.screen.dart';

import '../Widgets/post_card.dart';
import '../utils/utils.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isLoading = false;
  var userData = {};
  Uint8List? _file;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;
    } catch (e) {
      print("$e error");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                // top component
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          Uint8List file = await pickImage(ImageSource.gallery);
                          setState(() {
                            _file = file;
                          });
                        },
                        child: Icon(
                          IconlyLight.camera,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        onTap: () => print("notifications"),
                        child: Badge(
                          badgeContent: Text(
                            "0",
                            style: TextStyle(color: Colors.white),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          shape: BadgeShape.circle,
                          // position: BadgePosition.center(),
                          child: Icon(
                            IconlyLight.notification,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Flexible(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 3));
                      setState(() {
                        FirebaseFirestore.instance
                            .collection("posts")
                            .orderBy("datePublished", descending: false)
                            .snapshots();
                      });
                    },
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .orderBy("datePublished", descending: true)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Visibility(
                          visible: snapshot.hasData,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index].data();

                              return NewPostCard(snap: data);
                            },
                          ),
                          replacement: Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

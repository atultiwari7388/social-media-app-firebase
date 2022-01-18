import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Widgets/like_animations.widget.dart';
import 'package:instagram_clone/models/user.model.dart';
import 'package:instagram_clone/providers/user.provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, required this.snap}) : super(key: key);
  final snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLength = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.snap["postId"])
          .collection("comments")
          .get();
      commentLength = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 15.0, bottom: 15.0),
        child: Column(
          children: [
            TopWidgetSection(snap: widget.snap),
            SizedBox(height: 10),
            //post Section
            Column(
              children: [
                GestureDetector(
                  onDoubleTap: () async {
                    await FireStoreMethod().likePost(
                      widget.snap["postId"],
                      user.uid,
                      widget.snap["likes"],
                    );

                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.43,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.snap["postUrl"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                          child: Icon(
                            IconlyBold.heart,
                            color: Colors.red,
                            size: 70,
                          ),
                          isAnimating: isLikeAnimating,
                          duration: Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          // stops: [0.1, 0.9],
                          colors: [
                            Color(0xff00035B),
                            Color(0xff00035B),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CommentScreen(
                                    snap: widget.snap,
                                  ),
                                ),
                              );
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.comment,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "$commentLength",
                            style: TextStyle(color: Colors.white),
                          ),
                          LikeAnimation(
                            isAnimating:
                                widget.snap['likes'].contains(user.uid),
                            smallLike: true,
                            child: IconButton(
                                onPressed: () async {
                                  await FireStoreMethod().likePost(
                                    widget.snap["postId"],
                                    user.uid,
                                    widget.snap["likes"],
                                  );
                                },
                                icon: widget.snap['likes'].contains(user.uid)
                                    ? Icon(
                                        IconlyBold.heart,
                                        color: Colors.red,
                                      )
                                    : Icon(IconlyLight.heart,
                                        color: Colors.white)),
                          ),
                          Text(
                            "${widget.snap['likes'].length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 7,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.bookmark,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopWidgetSection extends StatelessWidget {
  const TopWidgetSection({
    Key? key,
    required this.snap,
  }) : super(key: key);

  final snap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(snap["profileImage"]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snap["name"],
                  style: GoogleFonts.lato(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "@${snap["userName"]}",
                  style: GoogleFonts.actor(
                    color: Colors.black87,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
      ],
    );
  }
}

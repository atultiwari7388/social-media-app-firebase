import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:getwidget/getwidget.dart';
import 'package:instagram_clone/Widgets/icon_and_text_btn.widget.dart';
import 'package:instagram_clone/Widgets/like_animations.widget.dart';
import 'package:instagram_clone/models/user.model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/user.provider.dart';
import '../resources/firestore_methods.dart';
import '../screens/full_view_image.dart';
import '../utils/utils.dart';

class NewPostCard extends StatefulWidget {
  const NewPostCard({Key? key, required this.snap}) : super(key: key);

  final snap;

  @override
  State<NewPostCard> createState() => _NewPostCardState();
}

class _NewPostCardState extends State<NewPostCard> {
  final TextEditingController _commentController = TextEditingController();

  bool isLikeAnimating = false;
  int commentLength = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
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
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 430,
      // color: Colors.red,
      child: Column(
        children: [
          // top Component
          topComponent(),
          SizedBox(height: 10),
          //post component
          postComponent(),
          //like and comment component

          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    await FireStoreMethod().likePost(
                      widget.snap["postId"],
                      user.uid,
                      widget.snap["likes"],
                    );
                  },
                  child: LikeAnimation(
                    isAnimating: widget.snap["likes"].contains(user.uid),
                    child: TextAndIconWidget(
                      icon: widget.snap['likes'].contains(user.uid)
                          ? IconlyBold.heart
                          : IconlyLight.heart,
                      color: widget.snap['likes'].contains(user.uid)
                          ? Colors.red
                          : Colors.grey,
                      text: "${widget.snap['likes'].length}",
                    ),
                  ),
                ),
                SizedBox(width: 40),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CommentScreen(
                          snap: widget.snap,
                        ),
                      ),
                    );
                  },
                  child: TextAndIconWidget(
                    icon: CupertinoIcons.conversation_bubble,
                    text: "$commentLength",
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 40),
                TextAndIconWidget(
                    icon: IconlyLight.bookmark, text: "0", color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  CachedNetworkImage postComponent() {
    return CachedNetworkImage(
      imageUrl: widget.snap["postUrl"],
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullPageImageView(snap: widget.snap),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          height: 270,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        height: 270,
        child: Center(
          child: Lottie.asset("assets/handloading.json"),
        ),
      ),
    );
  }

  Row topComponent() {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: widget.snap["profileImage"],
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 30,
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => GFShimmer(
            mainColor: Colors.grey,
            secondaryColor: Colors.grey.shade400,
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.snap["name"],
              ),
              Text(
                "@" + widget.snap["userName"],
              ),
            ],
          ),
        ),
        Container(
          child: Icon(IconlyLight.moreCircle),
        ),
      ],
    );
  }
}
























// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:instagram_clone/Widgets/like_animations.widget.dart';
// import 'package:instagram_clone/models/user.model.dart';
// import 'package:instagram_clone/providers/user.provider.dart';
// import 'package:instagram_clone/resources/firestore_methods.dart';
// import 'package:instagram_clone/utils/utils.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// class PostCard extends StatefulWidget {
//   const PostCard({Key? key, required this.snap}) : super(key: key);
//   final snap;

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   bool isLikeAnimating = false;
//   int commentLength = 0;

//   @override
//   void initState() {
//     super.initState();
//     getComments();
//   }

//   void getComments() async {
//     try {
//       QuerySnapshot snap = await FirebaseFirestore.instance
//           .collection("posts")
//           .doc(widget.snap["postId"])
//           .collection("comments")
//           .get();
//       commentLength = snap.docs.length;
//     } catch (e) {
//       showSnackBar(e.toString(), context);
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final User user = Provider.of<UserProvider>(context).getUser;

//     return Container(
//       child: Stack(
//         children: [
//           CachedNetworkImage(
//             imageUrl: widget.snap["postUrl"],
//             placeholder: (context, url) => Center(
//               child: Lottie.asset("assets/handloading.json"),
//             ),
//             imageBuilder: (context, imageProvider) => Container(
//               margin: EdgeInsets.all(15.0),
//               height: 450,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 1.0,
//                     offset: Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(35),
//                 image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   //profile image and name
//                   Container(
//                     margin: EdgeInsets.only(left: 10, bottom: 10),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage:
//                               NetworkImage(widget.snap["profileImage"]),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           widget.snap["name"],
//                           softWrap: true,
//                           style: GoogleFonts.lato(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     margin: EdgeInsets.only(left: 12, bottom: 30, right: 10),
//                     child: Text(
//                       widget.snap["description"],
//                       softWrap: true,
//                       style: GoogleFonts.lato(
//                         fontSize: 17.0,
//                         letterSpacing: 1.0,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             // top: 0,
//             right: 0,
//             child: Container(
//               margin: EdgeInsets.only(right: 15, top: 50, bottom: 0),
//               height: 350,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.3),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(7),
//                   bottomRight: Radius.circular(7),
//                   topLeft: Radius.circular(35),
//                   bottomLeft: Radius.circular(35),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     child: LikeAnimation(
//                       isAnimating: widget.snap['likes'].contains(user.uid),
//                       smallLike: true,
//                       child: IconButton(
//                           onPressed: () async {
//                             await FireStoreMethod().likePost(
//                               widget.snap["postId"],
//                               user.uid,
//                               widget.snap["likes"],
//                             );
//                           },
//                           icon: widget.snap['likes'].contains(user.uid)
//                               ? Icon(
//                                   IconlyBold.heart,
//                                   color: Colors.red,
//                                 )
//                               : Icon(IconlyBold.heart, color: Colors.white)),
//                     ),
//                     backgroundColor: Colors.white.withOpacity(0.356),
//                   ),
//                   Text("${widget.snap['likes'].length}"),
//                   CircleAvatar(
//                       radius: 30,
//                       child: FaIcon(FontAwesomeIcons.comment),
//                       backgroundColor: Colors.white.withOpacity(0.356)),
//                   Text("$commentLength"),
//                   CircleAvatar(
//                     radius: 30,
//                     child: Icon(IconlyLight.bookmark),
//                     backgroundColor: Colors.white.withOpacity(0.356),
//                   ),
//                   Text("1,233K"),
//                   CircleAvatar(
//                     radius: 30,
//                     child: Icon(IconlyLight.send),
//                     backgroundColor: Colors.white.withOpacity(0.356),
//                   ),
//                   Text("1,233K"),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

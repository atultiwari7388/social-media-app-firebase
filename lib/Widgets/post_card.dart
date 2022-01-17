// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:instagram_clone/utils/colors.dart';
// import 'package:intl/intl.dart';

// class PostCard extends StatefulWidget {
//   const PostCard({Key? key, required this.snap}) : super(key: key);

//   final snap;

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   showOptions() {
//     return showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12.0),
//               topRight: Radius.circular(12.0),
//             ),
//           ),
//           child: Wrap(
//             children: [
//               ListTile(
//                 title: Text('Share'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Unfollow'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Block'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Report'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //Header Section
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0)
//                 .copyWith(right: 0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundColor: Colors.white,
//                   backgroundImage: NetworkImage(widget.snap['profileImage']),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 8.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.snap['userName'],
//                           style: GoogleFonts.abel(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.more_vert),
//                   onPressed: showOptions,
//                 ),
//               ],
//             ),
//           ),

//           //Post Section

//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.35,
//             width: double.infinity,
//             child: Image.network(widget.snap['postUrl'], fit: BoxFit.cover),
//           ),

//           //Like comment section

//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart)),
//               IconButton(
//                   onPressed: () {}, icon: FaIcon(FontAwesomeIcons.comment)),
//               IconButton(
//                   onPressed: () {}, icon: FaIcon(FontAwesomeIcons.share)),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: FaIcon(FontAwesomeIcons.bookmark),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Description and number of comments

//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Widgets/like_animations.widget.dart';
import 'package:instagram_clone/models/user.model.dart';
import 'package:instagram_clone/providers/user.provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.snap}) : super(key: key);
  final snap;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          snap['userName'],
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          TopSection(snap: snap),
          Row(
            children: [
              LikeAnimation(
                isAnimating: snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FireStoreMethod().likePost(
                        snap["postId"],
                        user.uid,
                        snap["likes"],
                      );
                    },
                    icon: snap['likes'].contains(user.uid)
                        ? Icon(
                            IconlyBold.heart,
                            color: Colors.red,
                          )
                        : Icon(IconlyLight.heart)),
              ),
              IconButton(
                  onPressed: () {}, icon: FaIcon(FontAwesomeIcons.comment)),
              IconButton(
                  onPressed: () {}, icon: FaIcon(FontAwesomeIcons.share)),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.bookmark),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${snap['likes'].length} Likes",
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.laila(color: primaryColor),
                      children: [
                        TextSpan(
                          text: "${snap['userName']}   ",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: "${snap['description']}",
                        ),
                      ],
                    ),
                  ),
                ),

                // no of comments

                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "View all 280 comments",
                      style: GoogleFonts.raleway(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                //datetime

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    DateFormat.yMMMd().format(snap['datePublished'].toDate()),
                    style: GoogleFonts.raleway(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopSection extends StatefulWidget {
  const TopSection({
    Key? key,
    required this.snap,
  }) : super(key: key);

  final snap;

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
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
          Hero(
            tag: widget.snap['postUrl'],
            child: AspectRatio(
              aspectRatio: 4 / 3.5,
              child: Image.network(
                widget.snap['postUrl'],
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
    );
  }
}

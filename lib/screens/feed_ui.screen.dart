import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Widgets/post_card.dart';
import 'package:instagram_clone/utils/global_var.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          APPNAME,
          style: GoogleFonts.lato(color: Colors.black, fontSize: 23.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.chat,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .orderBy("likes", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data();

              return PostCard(snap: data);

              // return GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PostCard(
              //           snap: data,
              //         ),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(4.0),
              //     margin: const EdgeInsets.all(4.0),
              //     height: 230,
              //     width: double.infinity,
              //     child: Stack(
              //       alignment: Alignment.topLeft,
              //       children: [
              //         Hero(
              //           tag: data["postUrl"],
              //           child: Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15.0),
              //               image: DecorationImage(
              //                 image: NetworkImage(data["postUrl"]),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           bottom: 10,
              //           left: 0,
              //           right: 10,
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text(
              //               data["description"],
              //               overflow: TextOverflow.ellipsis,
              //               maxLines: 1,
              //               style: GoogleFonts.lato(
              //                 color: Colors.white,
              //                 fontSize: 26.0,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           top: -4,
              //           left: -4,
              //           child: CircleAvatar(
              //             radius: 30,
              //             backgroundImage: NetworkImage(
              //               data["profileImage"],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}

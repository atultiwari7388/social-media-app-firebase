import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key, required this.snap}) : super(key: key);
  final snap;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(widget.snap["profileImage"]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //username && description
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "@${widget.snap['userName']} ",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: "  ${widget.snap["text"]}",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // description
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Text(
                          DateFormat.yMMMEd()
                              .format(widget.snap["datePublished"].toDate())
                              .toString(),
                          style: GoogleFonts.laila(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          DateFormat.Hms()
                              .format(widget.snap["datePublished"].toDate())
                              .toString(),
                          style: GoogleFonts.laila(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //like button
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

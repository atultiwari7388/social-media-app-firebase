import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

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
          CircleAvatar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //username && description
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Username ",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Some Description ",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // description
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "23/12/2021",
                      style: GoogleFonts.laila(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
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

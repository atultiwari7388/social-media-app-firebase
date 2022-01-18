import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String name;
  final String description;
  final String uid;
  final String postId;
  final String userName;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  Post({
    required this.name,
    required this.description,
    required this.uid,
    required this.postId,
    required this.userName,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

//create document snapshot
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      name: snapshot['name'],
      userName: snapshot["userName"],
      uid: snapshot["uid"],
      profileImage: snapshot["profileImage"],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      postId: snapshot['postId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        "description": description,
        "uid": uid,
        "postId": postId,
        "userName": userName,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "likes": likes,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String profileImage;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.email,
    required this.uid,
    required this.profileImage,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "profileImage": profileImage,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  //create document snapshot

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userName: snapshot["userName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profileImage: snapshot["profileImage"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}

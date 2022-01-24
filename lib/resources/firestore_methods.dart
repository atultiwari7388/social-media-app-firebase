import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:instagram_clone/models/post.model.dart';
import 'package:instagram_clone/resources/storage_method.resources.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String name,
    String description,
    Uint8List file,
    String uid,
    String userName,
    String profileImage,
  ) async {
    String res = "Some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();
      //create post

      Post post = Post(
        name: name,
        description: description,
        uid: uid,
        userName: userName,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profileImage: profileImage,
        likes: [],
      );

      // uploaded to firebase

      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      print(e.toString());
    }

    return res;
  }

  // add post likes in firebase firestore

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // store comments in firebase firestore
  Future<void> postComment(
    String postId,
    String text,
    String uid,
    String userName,
    String profileImage,
    BuildContext context,
  ) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "profileImage": profileImage,
          "userName": userName,
          "uid": uid,
          "text": text,
          "datePublished": DateTime.now(),
          "commentId": commentId,
        });
      } else {
        showSnackBar("Text is Empty", context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//delete posts
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //follow users

  Future<void> followUser(String uid, String followUserId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection("users").doc(uid).get();
      List following = (snap.data()! as dynamic)["following"];

      if (following.contains(followUserId)) {
        //remove followers
        await _firestore.collection("users").doc(followUserId).update({
          "followers": FieldValue.arrayRemove([uid])
        });

        await _firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayRemove([followUserId])
        });
      } else {
        await _firestore.collection("users").doc(followUserId).update({
          "followers": FieldValue.arrayUnion([uid])
        });

        await _firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayUnion([followUserId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

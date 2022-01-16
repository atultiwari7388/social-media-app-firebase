import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.model.dart';
import 'package:instagram_clone/resources/storage_method.resources.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadPost(
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
}

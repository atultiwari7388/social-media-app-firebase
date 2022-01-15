import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_method.resources.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  // create account user
  Future<String> createUserAccount({
    required String email,
    required String password,
    required String bio,
    required String userName,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          userName.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        //register user
        UserCredential _userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        // print(_userCredential.user!.uid);

        // save image to databse
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profileImage', file, false);

        // add user to database
        await _firebase.collection("users").doc(_userCredential.user!.uid).set({
          "uid": _userCredential.user!.uid,
          "userName": userName,
          "email": email,
          "bio": bio,
          "followers": [],
          "following": [],
          "profileImage": photoUrl,
        });
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

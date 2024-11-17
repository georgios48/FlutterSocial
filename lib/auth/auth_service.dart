import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_social/model/user_model.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  // sign in
  Future<UserModel?> signInWithEmailPw(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user =
          UserModel(uuid: userCredential.user!.uid, email: email, name: "");
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login failed: ${e.code}");
    }
  }

  // sign up
  Future<UserModel?> signUpWithEmailPw(String name, email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user =
          UserModel(uuid: userCredential.user!.uid, email: email, name: name);

      // save data in firebase
      await firebaseFireStore
          .collection("users")
          .doc(user.uuid)
          .set(user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login failed: ${e.code}");
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // get current user
  Future<UserModel?> getCurrentUser() async {
    // current logged in firebase
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    // user exists
    UserModel currentUser =
        UserModel(uuid: user.uid, email: user.email!, name: "");

    return currentUser;
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thsyd/models/thsyd_user.dart';

class AuthRepository {
  AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  Stream<User?> get user => firebaseAuth.userChanges();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Create user data on Firestore
    await createUserInFirestore(userCredential.user);

    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["email", "public_profile"]);

    // Create credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    // Create user data on Firestore
    await createUserInFirestore(userCredential.user);

    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<void> createUserInFirestore(User? user) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection("users");

      if (user != null) {
        await users.add(
          THSYDUser(
            username: user.displayName ?? "username",
          ).toMap(),
        );
      }
    } catch (error) {
      log("$error");
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut(); // Sign out from Firebase Auth
      if (googleSignIn.currentUser != null) {
        await googleSignIn.disconnect(); // Disconnect from Google Sign-In
        await googleSignIn.signOut(); // Sign out from Google Sign-In
      }
    } catch (error) {
      log('Error signing out: $error');
      // Handle the error as needed, such as displaying an error message.
    }
  }
}

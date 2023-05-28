import 'package:appmovil/pages/main_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {

  static firebaseInit(context) async {
    try {
      FirebaseApp app = await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainAppViaje()),
            (Route<dynamic> route) => false);
      }

      return app;
    } catch (e) {
      return null;
    }
  }

   static Future<dynamic> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User Sign Out");
    } catch (e) {
      print("error");
      print(e);
    }
  }

  static Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow

      GoogleSignIn signIn = GoogleSignIn(scopes: ["email"]);

      final GoogleSignInAccount? googleUser = await signIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

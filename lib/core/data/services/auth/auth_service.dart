import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

class AuthService {
  final FirebaseAuth auth;

  AuthService({required this.auth});

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ErrorModel(errMessage: 'Weak Password');
      } else if (e.code == 'email-already-in-use') {
        throw ErrorModel(
          errMessage: 'The account already exists for that email.',
        );
      }
      throw ErrorModel(errMessage: e.toString());
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw ErrorModel(errMessage: ' Wrong email or Password');
      } else {
        log(e.toString());
        throw ErrorModel(errMessage: 'Something went wrong: ${e.message}');
      }
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw ErrorModel(errMessage: ' Wrong email or Password');
      } else {
        log(e.toString());
        throw ErrorModel(errMessage: 'Something went wrong: ${e.message}');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw ErrorModel(errMessage: 'Google sign-in was cancelled.');
      }

      // Obtain the auth details from the request

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      log('Google Sign-In Error: $e');
      throw ErrorModel(errMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  // Future<UserCredential> signInWithFacebook() async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();

  //     if (loginResult.status != LoginStatus.success ||
  //         loginResult.accessToken == null) {
  //       throw ErrorModel(
  //         errMessage: loginResult.message ?? 'Facebook sign-in failed.',
  //       );
  //     }

  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //     return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   } on Exception catch (e) {
  //     throw ErrorModel(errMessage: 'Something went wrong: ${e.toString()}');
  //   }
  // }
}

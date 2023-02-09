import 'dart:developer';

import 'package:eleverdev/data/models/firebase_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseResponse> createAccount(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      log(userCredential.user!.email.toString());
      return FirebaseResponse(status: true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return FirebaseResponse(
              status: false, errorMessage: 'email already taken');
        case 'invalid-email':
          return FirebaseResponse(
              status: false, errorMessage: 'email is invaild');
        case 'weak-password':
          return FirebaseResponse(
              status: false, errorMessage: 'password is weak');
        default:
          return FirebaseResponse(
              status: false, errorMessage: 'some error occured');
      }
    } catch (e) {
      return FirebaseResponse(
          status: false, errorMessage: 'some error occured');
    }
  }
}

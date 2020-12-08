import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'stripe_server.dart';

class AuthApi {
  Future signIn(String emailId, String password) async {
    try {
      final result = await login(emailId, password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        try {
          final result = await signUp(emailId, password);
          return result.user;
        } on FirebaseAuthException catch (e) {
          return e.code;
        }
      } else
        return e.code;
    }
  }

  Future<UserCredential> signUp(String emailId, String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailId, password: password);
    final customerId = await StripeServer().createCustomer(emailId);
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(credential.user.uid)
        .set(customerId);
    return credential;
  }

  Future<UserCredential> login(String emailId, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailId, password: password);
  }

  Future<String> getCustomerId() async {
    final snapshot = await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(FirebaseAuth.instance.currentUser.uid)
        .once();
    return snapshot.value;
  }
}

import '/src/app_export.dart';

class LoginDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}

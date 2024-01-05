import '../data_source/login_data_source.dart';
import '/src/app_export.dart';

class LoginRepository {
  final LoginDataSource _loginDataSource;

  LoginRepository(this._loginDataSource);

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _loginDataSource.signIn(email: email, password: password);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }
}

import '../../../src/app_export.dart';
import '../data/repository/login_repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginBloc(
    this._loginRepository,
  ) : super(LoginInitial());

  static LoginBloc get(context) => BlocProvider.of<LoginBloc>(context);

  final GlobalKey<FormState> formKey = GlobalKey();
  final ScrollController pageScrollController = ScrollController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        await _loginRepository.signIn(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim(),
        );
        emit(LoginCompleted());
      } catch (error) {
        String errorMessage;
        switch ((error as FirebaseAuthException).code) {
          case 'invalid-credential':
            errorMessage = 'معلومات غير صحيحة';
          default:
            errorMessage = 'حدث خطأ ما: يرجى التأكد من صحة المعلومات المدخلة';
        }
        emit(
          LoginError(errorMessage: errorMessage),
        );
      }
    }
  }

  void clearControllers() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(LogoutCompleted());
  }
}

import '../../../src/app_export.dart';
import '../data/repository/login_repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginBloc(
    this._loginRepository,
  ) : super(LoginInitial());

  static LoginBloc get(context) => BlocProvider.of<LoginBloc>(context);

  final ScrollController pageScrollController = ScrollController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  Future<void> signIn() async {
    UserCredential data = await _loginRepository.signIn(
      // email: emailTextController.text,
      // password: passwordTextController.text,
      email: 'admin@hadramout-hamza.com',
      password: '123456',
    ) as UserCredential;
    print(data.user!.uid);
  }
}

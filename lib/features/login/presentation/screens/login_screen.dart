import '../widgets/login_text_field.dart';
import '/features/login/cubit/login_cubit.dart';
import '/src/app_export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOp100,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                const ColoredBox(
                  color: AppColors.yellowOp100,
                  child: SizedBox.expand(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageConstants.img91x177,
                    height: 450,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Scrollbar(
              controller: LoginBloc.get(context).pageScrollController,
              thumbVisibility: true,
              trackVisibility: true,
              interactive: true,
              thickness: 6.0,
              child: CustomScrollView(
                controller: LoginBloc.get(context).pageScrollController,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: SizedBox(
                            width: 500,
                            child: Column(
                              children: [
                                const Text(
                                  'تسجيل الدخول',
                                  style: AppTextStyles.font32BlackBold,
                                ),
                                const Gap(28),
                                LoginTextField(
                                  controller: LoginBloc.get(context)
                                      .emailTextController,
                                  inputType: TextInputType.emailAddress,
                                  icon: Icons.email,
                                  hintText: 'البريد الالكتروني',
                                ),
                                const Gap(20),
                                LoginTextField(
                                  controller: LoginBloc.get(context)
                                      .passwordTextController,
                                  inputType: TextInputType.text,
                                  icon: Icons.lock_rounded,
                                  isPassword: true,
                                  hintText: 'كلمة المرور',
                                ),
                                const Gap(40),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: AppButtonStyles
                                      .buttonYellowSize457x66Rounded10
                                      .copyWith(
                                    fixedSize: MaterialStateProperty.all(
                                      const Size(470, 71),
                                    ),
                                    elevation:
                                        const MaterialStatePropertyAll(0),
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.zero),
                                  ),
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: AppTextStyles.font20WhiteBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import '/core/widgets/loading_circle.dart';
import '/src/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        Router.neglect(
          context,
          () => context.go(AppRoutes.loginScreen),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.img91x177,
                  height: 160.h,
                ),
                Gap(30.r),
                Text(
                  'قيد التطوير حاليا',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 30.h,
                  ),
                ),
                Gap(60.r),
                SizedBox.square(
                  dimension: 30.h,
                  child: const LoadingSpinningCircle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

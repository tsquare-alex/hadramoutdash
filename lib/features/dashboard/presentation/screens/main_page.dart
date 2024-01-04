import '/src/app_export.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteOp100,
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}

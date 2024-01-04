import '/src/app_export.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteOp100,
      body: Center(
        child: Text('Menu Page'),
      ),
    );
  }
}

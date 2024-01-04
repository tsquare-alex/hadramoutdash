import '../../src/app_export.dart';

class LoadingSpinningCircle extends StatelessWidget {
  const LoadingSpinningCircle({
    super.key,
    this.color,
  });

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.brownOp100,
        strokeWidth: 6.r,
      ),
    );
  }
}

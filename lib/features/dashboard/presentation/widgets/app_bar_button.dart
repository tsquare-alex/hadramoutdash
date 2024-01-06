import 'package:hadramoutdash/src/app_export.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.toolTip,
  });

  final String icon;
  final Function onTap;
  final String? toolTip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTap();
      },
      child: Tooltip(
        message: toolTip ?? '',
        decoration: BoxDecoration(
          color: AppColors.yellowOp100,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(icon, width: 18 , height: 20,),
      ),
    );
  }
}

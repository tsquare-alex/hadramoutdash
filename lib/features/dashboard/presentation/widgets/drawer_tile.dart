import 'package:hadramoutdash/src/app_export.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.isSelected,
    required this.label,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.onTap,
    required this.toolTip,
  });

  final bool isSelected;
  final String label;
  final String selectedIcon;
  final String unSelectedIcon;
  final Function onTap;
  final String toolTip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => onTap(),
        splashColor: Colors.transparent,
        hoverColor: AppColors.yellowOp10,
        borderRadius: BorderRadius.circular(10),
        child: Tooltip(
          message: ResponsiveValue(
            context,
            defaultValue: '',
            conditionalValues: [
              Condition.smallerThan(
                  value: isSelected ? '' : toolTip, name: DESKTOP),
            ],
          ).value,
          decoration: BoxDecoration(
            color: AppColors.yellowOp100,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 57,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.yellowOp100 : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: ResponsiveValue(
                context,
                defaultValue: MainAxisAlignment.start,
                conditionalValues: [
                  Condition.smallerThan(
                      value: MainAxisAlignment.center, name: DESKTOP)
                ],
              ).value!,
              children: [
                Image.asset(
                  isSelected ? selectedIcon : unSelectedIcon,
                  height: 20.5,
                  width: 24,
                ),
                ResponsiveVisibility(
                  hiddenConditions: [
                    Condition.smallerThan(value: false, name: DESKTOP),
                  ],
                  child: const Gap(14),
                ),
                ResponsiveVisibility(
                  hiddenConditions: [
                    Condition.smallerThan(value: false, name: DESKTOP),
                  ],
                  child: Text(
                    label,
                    style: isSelected
                        ? AppTextStyles.font20WhiteMedium
                        : AppTextStyles.font20BlackOp25Regular,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

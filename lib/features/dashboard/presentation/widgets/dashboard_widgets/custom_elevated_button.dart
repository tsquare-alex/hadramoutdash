import 'package:flutter/material.dart';
import 'package:hadramoutdash/src/app_export.dart';

import '../../../../../core/themes/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: AppButtonStyles.buttonYellowSize167x58Rounded10,
      onPressed: onPressed,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Icon(icon, color: AppColors.whiteOp100),
          ),
          ResponsiveVisibility(
            hiddenConditions: [
              Condition.smallerThan(value: false, name: DESKTOP),
            ],
            child:   Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              label,
              style: AppTextStyles.font14WhiteBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),),
        ],
      ),
    );
  }
}




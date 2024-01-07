import 'package:flutter/material.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_value.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/themes/styles.dart';

class CustomDialogButton extends StatelessWidget {
  const CustomDialogButton({super.key, required this.label, required this.onPressed, required this.isLoading,
    // required this.isLoading
  });
  final String label;
  final VoidCallback onPressed;
  // final bool isLoading;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellowOp100,
        minimumSize: const Size(662, 96),
        maximumSize: const Size(662, 96),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )
      ),
      onPressed:isLoading ? null : onPressed,
      child:   isLoading
          ? const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 10), // Adjust spacing as needed
          Text(
            "تحميل...",
            style: TextStyle(color: AppColors.whiteOp100,fontSize: 35),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      )
          : Text(
        label,
        style:AppTextStyles.font32WhiteSemiBold,

      )
    );
  }
}

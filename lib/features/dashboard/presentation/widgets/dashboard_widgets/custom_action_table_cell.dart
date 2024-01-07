import 'package:flutter/material.dart';
import 'package:hadramoutdash/core/themes/styles.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_value.dart';

import '../../../../../core/themes/colors.dart';

class CustomActionTableCell extends StatelessWidget {
  const CustomActionTableCell({
    Key? key,
    required VoidCallback onElevatedButtonPressed,
    required VoidCallback onIconButtonPressed,
  })
      : _onElevatedButtonPressed = onElevatedButtonPressed,
        _onIconButtonPressed = onIconButtonPressed,
        super(key: key);

  final VoidCallback _onElevatedButtonPressed;
  final VoidCallback _onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _onIconButtonPressed,
              child: const CircleAvatar(
                  backgroundColor: AppColors.redOp10,
                  child: Icon(
                    Icons.delete_outline_outlined, color: AppColors.redOp100,)),
            ),

            const SizedBox(width: 10), // Add spacing of 10 between buttons
            ResponsiveVisibility(
              hiddenConditions: [
                Condition.smallerThan(value: false, name: DESKTOP),
              ],
              child: Flexible(
                fit: FlexFit.tight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(117, 47),
                      maximumSize: const Size(117, 47),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: AppColors.yellowOp100
                  ),
                  onPressed: _onElevatedButtonPressed,
                  child:  Text(
                    "تعديل",
                    maxLines: 1,
                    style:
                    AppTextStyles.font16WhiteBold,

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
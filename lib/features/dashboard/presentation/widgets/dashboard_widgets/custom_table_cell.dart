
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hadramoutdash/core/themes/colors.dart';
import 'package:hadramoutdash/core/themes/styles.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_value.dart';
class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    Key? key,
    required this.title,
    this.icon,
    this.onIconTap,
    this.image,  this.size = 14,
    this.isTitle =   false,
  }) : super(key: key);

  final String title;
  final IconData? icon;
  final VoidCallback? onIconTap;
  final String? image;
   final double size;
   final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          if (icon != null)
            GestureDetector(
              onTap: onIconTap,
              child: Icon(icon, color: AppColors.blackOp100),
            ),
          if (icon != null) SizedBox(width: 8),
          if (image != null)
            ResponsiveVisibility(
              hiddenConditions: [
                Condition.smallerThan(value: false, name: DESKTOP),
              ],
              child: CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: Image.network(
                    image!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/dashboard_logo.png");
                    },
                  ),
                ),
              ),
            ),

          const Gap(15),
          Flexible(
            child: Text(
              title,
              style:isTitle ?  AppTextStyles.font24BlackSemiBold : AppTextStyles.font16BlackSemiBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),


        ],
      ),
    );
  }
}



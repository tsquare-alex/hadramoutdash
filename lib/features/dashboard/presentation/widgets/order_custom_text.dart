import 'package:flutter/material.dart';
import 'package:hadramoutdash/core/themes/colors.dart';

import '../../../../core/themes/styles.dart';

class OrderCustomText extends StatelessWidget {
  const OrderCustomText(
      {super.key,
        required this.title,

        this.maxLin = 1,
        this.textAlign = TextAlign.center,
        this.fontWeight = FontWeight.bold, this.isTitle = false,
        // required this.size
      });

  final String title;

  final int maxLin;
  final TextAlign textAlign;
  // final double size;
  final FontWeight fontWeight;
  final bool isTitle ;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: isTitle ?  AppTextStyles.font24BlackSemiBold : AppTextStyles.font20YellowBold,


      maxLines: maxLin,
      textAlign:textAlign ,
    );
  }
}

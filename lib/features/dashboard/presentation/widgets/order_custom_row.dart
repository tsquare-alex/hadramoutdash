import 'package:flutter/material.dart';

import 'custom_text.dart';
import 'order_custom_text.dart';

class OrderCustomRow extends StatelessWidget {
  const OrderCustomRow({
    super.key,
    required this.title, required this.info,
  });

  final String  title;
  final String  info;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OrderCustomText(
          title:"$title:   ",

        ),
        Flexible(
          child: CustomText(
            title: info,
            isTitle: false,
          ),
        ),
      ],
    );
  }
}
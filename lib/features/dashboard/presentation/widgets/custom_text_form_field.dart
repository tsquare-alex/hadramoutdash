// import 'package:flutter/material.dart';
// import 'package:hadramoutdash/core/themes/colors.dart';
// class CustomTextFormField extends StatelessWidget {
//   CustomTextFormField({ required this.hintText, this.maxLines = 1,  required this.controller,required this.validationText})
//       ;
//
//   final String hintText;
//   final int maxLines;
//   final TextEditingController controller;
//   final String validationText;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         fillColor: AppColors.whiteOp100,
//         filled: true,
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             width: 2,
//             color: AppColors.greyOp50,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             width: 2,
//             color: AppColors.greyOp50,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             width: 2,
//             color: AppColors.greyOp50,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             width: 2,
//             color: AppColors.greyOp50,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             width: 2,
//             color: AppColors.redOp100,
//           ),
//         ),
//       ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return validationText;
//           }
//           return null;
//         }
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:hadramoutdash/core/themes/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.hintText,
    this.maxLines = 1,
    required this.controller,
    required this.validationText,
    required this.validator, // Add a custom validator parameter
  });

  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final String validationText;
  final String? Function(String?)? validator; // Custom validator function

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: AppColors.whiteOp100,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 25,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.greyOp50,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.greyOp50,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.greyOp50,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.greyOp50,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.redOp100,
          ),
        ),
      ),
      validator: validator, // Use the custom validator
    );
  }
}

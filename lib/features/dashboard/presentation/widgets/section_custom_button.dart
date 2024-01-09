import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';

class SectionCustomActionButton extends StatelessWidget {
  const SectionCustomActionButton({
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
    return Container(
      // width: 315,
      // padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: _onElevatedButtonPressed,
            child:  CircleAvatar(
              backgroundColor: AppColors.yellowOp10,
              child: Image.asset("assets/images/edit.png"),
            ),
          ),


          const SizedBox(width: 10),
          InkWell(
            onTap: _onIconButtonPressed,
            child: const CircleAvatar(
                backgroundColor: AppColors.redOp10,
                child: Icon(
                  Icons.delete_outline_outlined, color: AppColors.redOp100,)),
          ),
        ],
      ),
    );
  }
}
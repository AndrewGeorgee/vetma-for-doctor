import 'package:flutter/material.dart';

import '../../../core/resources/colors.dart';

class BottomWithOutBackgraund extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const BottomWithOutBackgraund(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        //  color: ColorManager.prymaryColor,
        border: Border.all(
          color: ColorManager.prymaryColor,
          width: 3.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(35.0) //
            ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: ColorManager.prymaryColor,
          ),
        ),
      ),
    );
  }
}

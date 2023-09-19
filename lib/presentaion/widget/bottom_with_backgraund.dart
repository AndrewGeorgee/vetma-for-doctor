import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resources/colors.dart';

class BottomWithBackgraund extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BottomWithBackgraund(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: ColorManager.prymaryColor,
        border: Border.all(
          color: ColorManager.prymaryColor,
          width: 5.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(35.0) //
            ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          // textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class BottomWithBackgraund2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BottomWithBackgraund2(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      //margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: ColorManager.prymaryColor,
        border: Border.all(
          color: ColorManager.prymaryColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(35.0) //
            ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          // textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

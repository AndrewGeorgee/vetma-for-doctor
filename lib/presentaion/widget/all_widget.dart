import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget leadingBottom({
  required VoidCallback onPressed,
}) {
  return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_sharp,
        color: Colors.black,
        size: 30,
      ));
}

Widget textHedaer({required String text}) {
  return Text(
    text,
    style: GoogleFonts.inter(
        color: ColorManager.prymaryColor,
        fontSize: 35,
        decorationStyle: TextDecorationStyle.dotted,
        fontWeight: FontWeight.w700),
  );
}

Widget textHedaer18({required String text}) {
  return Text(
    text,
    style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 25,
        decorationStyle: TextDecorationStyle.dotted,
        fontWeight: FontWeight.bold),
  );
}

Widget textHedaer27({required String text}) {
  return Text(
    text,
    style: GoogleFonts.inter(
        color: ColorManager.prymaryColor,
        fontSize: 35,
        decorationStyle: TextDecorationStyle.dotted,
        fontWeight: FontWeight.w700),
  );
}

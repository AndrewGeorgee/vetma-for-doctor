// ignore: depend_on_referenced_packages
import 'dart:async';
import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resources/assets_manger.dart';
import '../../../core/resources/routes_manager.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  Timer? timer;
  startDelay() {
    timer = Timer(const Duration(seconds: 5), goNext);
  }

  goNext() {
    Navigator.pushReplacementNamed(context, Routes.onBoarding);
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Image(
                image: AssetImage(
                  AssetsManager.logo,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Text('Of Doctor',
                textAlign: TextAlign.left,
                style: GoogleFonts.acme(
                    color: ColorManager.prymaryColor,
                    fontSize: 25,
                    decorationStyle: TextDecorationStyle.dotted,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

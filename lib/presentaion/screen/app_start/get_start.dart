import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manger.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/routes_manager.dart';
import '../../widget/bottom_with_backgraund.dart';
import '../../widget/bottom_without_back.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // ignore: sized_box_for_whitespace
                const SizedBox(height: 150),
                SizedBox(
                  width: 200,
                  height: 55,
                  child: Image(
                    image: AssetImage(
                      AssetsManager.logo,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: Text('OF DOCTOR',
                      style: GoogleFonts.courgette(
                          color: ColorManager.prymaryColor,
                          fontSize: 30,
                          decorationStyle: TextDecorationStyle.dotted,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 30),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Let’s get started!',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Center(
                  child: Text(
                    'Login to enjoy the features we’ve provided, and stay healthy!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 30),
                BottomWithBackgraund2(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  text: 'Login',
                ),
                const SizedBox(height: 10),

                BottomWithOutBackgraund(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.registerRoute);
                  },
                  text: 'Sign Up',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

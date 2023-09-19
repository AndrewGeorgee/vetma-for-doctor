import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/resources/routes_manager.dart';

class BoardingModel {
  final String image;
  final String title;

  BoardingModel({
    required this.title,
    required this.image,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/doctor/onboarding1.png',
    title: 'Consult only with a doctor you trust',
  ),
  BoardingModel(
    image: 'assets/doctor/onboarding2.png',
    title: 'Find a lot of specialist doctors in one place',
  ),
  BoardingModel(
    image: 'assets/doctor/onboarding3.png',
    title: 'Get connect our Online Consultation',
  ),
];
bool isLast = false;
int index = 0;
var boardController = PageController();

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.getStart);
            },
            child: Text(
              'Skip',
              style: TextStyle(color: ColorManager.prymaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: ColorManager.profile,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: ColorManager.prymaryColor,
          // border: Border.all(
          //   color: ColorManager.prymaryColor,
          //   width: 5.0,
          // ),
          borderRadius: const BorderRadius.all(Radius.circular(35.0) //
              ),
        ),
        child: IconButton(
            icon: const Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              if (isLast) {
                Navigator.pushReplacementNamed(context, Routes.getStart);
              } else {
                boardController.nextPage(
                  duration: const Duration(
                    milliseconds: 750,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              }
            }),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(model.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                  color: Colors.black,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  decorationStyle: TextDecorationStyle.dotted,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );
}

// // ignore_for_file: dead_code, unused_local_variable

// ignore_for_file: dead_code

import 'package:doctor_of_vetma/presentaion/screen/auth/forget_password_screen.dart';
import 'package:doctor_of_vetma/presentaion/screen/auth/login_screen.dart';
import 'package:doctor_of_vetma/presentaion/screen/auth/sign_up.dart';
import 'package:doctor_of_vetma/presentaion/screen/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../presentaion/screen/app_start/get_start.dart';
import '../../presentaion/screen/app_start/on_boarding_screen.dart';
import '../../presentaion/screen/app_start/splach_screen.dart';

class Routes {
  static const splashRoute = '/';
  static const onBoarding = '/onBoarding';
  static const getStart = '/getStart';
  static const loginRoute = '/loginRoute';
  static const registerRoute = '/registerRoute';
  static const forgetPasswordRoute = '/forgetPasswordRoute';
  static const mainScreenRoute = '/mainScreenRoute';
}

class RouteGenerateor {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return PageTransition(
          //  childCurrent: Text(''),
          alignment: Alignment.topCenter, 
          type: PageTransitionType.fade,
          child: const SplachScreen(),
        );

        break;
      case Routes.onBoarding:
        return PageTransition(
          //  childCurrent: Text(''), 
          alignment: Alignment.topCenter,
          type: PageTransitionType.fade,
          child: const OnBoardingScreen(),
        );
        break;

      case Routes.getStart:
        return PageTransition(
          //  childCurrent: Text(''),
          alignment: Alignment.topCenter,
          type: PageTransitionType.fade,
          child: const GetStartScreen(),
        );
        break;
      case Routes.loginRoute:
        return PageTransition(
          //  childCurrent: Text(''),
          alignment: Alignment.topCenter,
          type: PageTransitionType.fade,
          child: const LoginScreen(),
        );
        break;
      case Routes.registerRoute:
        return PageTransition(
          //  childCurrent: Text(''),
          alignment: Alignment.topCenter,
          type: PageTransitionType.fade,
          child: const SignUpScreen(),
        );
        break;
      case Routes.forgetPasswordRoute:
        return PageTransition(
          //  childCurrent: Text(''),
          alignment: Alignment.topCenter,
          type: PageTransitionType.fade,
          child: const ForgetPasswordScreen(),
        );
        break;
        case Routes.mainScreenRoute:
        return PageTransition(
          //  childCurrent: Text(''),
          alignment: Alignment.topCenter,
          type: PageTransitionType.fade,
          child: const MainScreen(),
        );
        break;
      default:
        return unDefindRoute();
    }
  }

  static Route<dynamic> unDefindRoute() {
    return PageTransition(
      //  childCurrent: MainScreen(),
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      type: PageTransitionType.fade,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'No Route Fond',
          ),
        ),
        body: const Center(
          child: Text(
            'No Route Fond',
          ),
        ),
      ),
    );
  }
}

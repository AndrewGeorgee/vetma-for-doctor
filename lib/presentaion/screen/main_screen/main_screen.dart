import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/resources/colors.dart';
import 'nav_screen/dashboard_screen.dart';
import 'nav_screen/patients_appointment.dart';
import 'nav_screen/setings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List screenBottomNav = [
    const DashboardScreen(),
    const PatientsAppointment(),
     SettingScreen(),
  ];
  void changeScreenBottom(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) const PatientsAppointment();
      if (index == 2)  SettingScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBottomNav[_currentIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 1.5,
              blurRadius: 7,
              //offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              changeScreenBottom(index);
              print('Screen  $index');
            });
          },
          gap: 8,
          activeColor: ColorManager.prymaryColor,
          tabs: [
            //! Home Screen
            GButton(
              icon: FontAwesomeIcons.houseMedical,

              //  textSize: 20,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: ColorManager.prymaryColor,
                  fontWeight: FontWeight.bold),
            ),
            //!  Notification Screen
            GButton(
              icon: FontAwesomeIcons.calendarCheck,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: ColorManager.prymaryColor,
                  fontWeight: FontWeight.bold),
            ),
            //! Profile Screen
            GButton(
              icon: FontAwesomeIcons.userDoctor,
              text: 'Profile',
              textStyle: TextStyle(
                  fontSize: 20,
                  color: ColorManager.prymaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

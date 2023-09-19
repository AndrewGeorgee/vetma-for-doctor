import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:doctor_of_vetma/presentaion/screen/settings/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../settings/add_appointment.dart';
import '../../settings/all_appointment_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final DateTime now;
  late final String day;
  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    day = DateFormat('EEEE').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Settings ',
                    style: GoogleFonts.inter(
                        color: ColorManager.prymaryColor,
                        fontSize: 50,
                        decorationStyle: TextDecorationStyle.dotted,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    const FaIcon(FontAwesomeIcons.user, size: 25),
                    const SizedBox(width: 10),
                    Text(
                      'Accounts',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 25,
                          decorationStyle: TextDecorationStyle.dotted,
                          fontWeight: FontWeight.w700),
                    )
                  ]),
                ),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditRofileScreen(),
                          ));
                    },
                    child: listTitle(text: 'Edit Profile', onPressed: () {})),
                const SizedBox(height: 20),
                listTitle(text: 'Change Password', onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Appointment',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 25,
                            decorationStyle: TextDecorationStyle.dotted,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllAppointment(),
                          ));
                    },
                    child: listTitle(
                        text: 'All of Appointment', onPressed: () {})),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddAppointmentScreen(),
                        ));
                  },
                  child: listTitle(text: 'Add Appointment', onPressed: () {}),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.language_rounded,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'More',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 25,
                            decorationStyle: TextDecorationStyle.dotted,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (BuildContext context) {
                            return Container(
                                height: 200,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0))),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'English',
                                              style: GoogleFonts.inter(
                                                  color:
                                                      ColorManager.prymaryColor,
                                                  fontSize: 20,
                                                  decorationStyle:
                                                      TextDecorationStyle
                                                          .dotted,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'عربي',
                                              style: GoogleFonts.inter(
                                                  color:
                                                      ColorManager.prymaryColor,
                                                  fontSize: 30,
                                                  decorationStyle:
                                                      TextDecorationStyle
                                                          .dotted,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      )
                                    ]));
                          },
                          context: context);
                    },
                    child: listTitle(text: 'Launguage', onPressed: () {})),
                const SizedBox(height: 10),
                listTitle(text: 'Country', onPressed: () {}),
                const SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_outlined, size: 35),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              'Logout',
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 20,
                                  decorationStyle: TextDecorationStyle.dotted,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listTitle({required String text, required VoidCallback onPressed}) {
    return ListTile(
      minLeadingWidth: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: ColorManager.switchColor, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(30),
      ),
      leading: Text(
        text,
        style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20,
            decorationStyle: TextDecorationStyle.dotted,
            fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.circleArrowRight,
        ),
        onPressed: () => onPressed,
      ),
    );
  }
}

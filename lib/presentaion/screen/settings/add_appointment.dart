// ignore_for_file: sized_box_for_whitespace

import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_cubit.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_state.dart';
import 'package:doctor_of_vetma/presentaion/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/save_appointment_of_doctor.dart';
import '../../widget/bottom_with_backgraund.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<String> time = [
    '10 AM',
    '11 Am',
    '12 PM',
    '1 PM ',
    '2 PM ',
    '3 PM ',
    '4 PM ',
    '5 PM ',
    '6 PM ',
    '7 PM ',
    '8 PM ',
    '9 PM ',
    '10 PM',
    '11 PM',
  ];

  int selectedIndexDay = 0;
  int selectedIndexTime = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: leadingBottom(onPressed: () {}),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: textHedaer(text: 'Add Appointment')),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: textHedaer18(text: 'Inter Date'),
                ),
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndexDay = index;
                                print(selectedIndexDay);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 25),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.brown,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: selectedIndexDay == index
                                      ? ColorManager.prymaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(day[index],
                                      style: GoogleFonts.inter(
                                          color: selectedIndexDay == index
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 30,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: textHedaer18(text: 'Inter Time'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 150,
                  child: GridView.builder(
                    itemCount: time.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 90 / 2),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndexTime = index;
                                print(selectedIndexDay);
                              });
                            },
                            child: Container(
                              // margin: const EdgeInsets.symmetric(
                              //     horizontal: 8, vertical: 15),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: selectedIndexTime == index
                                    ? ColorManager.prymaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.brown,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(time[index],
                                      style: GoogleFonts.inter(
                                          color: selectedIndexTime == index
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 15,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BottomWithBackgraund(
                  onPressed: () {
                    DoctorCubit.get(context).saveAppointment(AppointmentDoctor(
                      dayOfAppointment: day[selectedIndexDay],
                      timeOfAppointment: time[selectedIndexTime],
                      idOfAppointment: '',
                    ));
                  },
                  text: 'Save Appoitment',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

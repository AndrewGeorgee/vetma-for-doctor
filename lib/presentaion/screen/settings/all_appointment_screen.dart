import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:doctor_of_vetma/presentaion/widget/tost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/save_appointment_of_doctor.dart';
import '../../controller/mainCubit/doctor_cubit.dart';
import '../../widget/all_widget.dart';

class AllAppointment extends StatelessWidget {
  const AllAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointmentInterByDoctor')
            .where('idOfDoctor',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('dayOfAppointment',
                isEqualTo: day)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!.docs
                .map((doc) => AppointmentDoctor.fromSnapshot(doc))
                .toList();
            if (user.isEmpty) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: leadingBottom(onPressed: () {}),
                    title: textHedaer27(text: 'All Appointment'),
                    centerTitle: true,
                  ),
                  body: const Center(
                      child: Text(
                    'No Appointment Go\n To Add Apoointment',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  )));
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: leadingBottom(onPressed: () {}),
                title: textHedaer27(text: 'All Appointment'),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textHedaer(text: 'Day'),
                          const Spacer(),
                          const SizedBox(
                            width: 27,
                          ),
                          textHedaer(text: 'Time'),
                          const Spacer(),
                          textHedaer(text: 'Edit'),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final appointment = user[index];
                            log(appointment.timeOfAppointment);
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        appointment.dayOfAppointment,
                                        style: GoogleFonts.inter(
                                            fontSize: 25,
                                            decorationStyle:
                                                TextDecorationStyle.dotted,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        appointment.timeOfAppointment,
                                        style: GoogleFonts.inter(
                                            fontSize: 25,
                                            decorationStyle:
                                                TextDecorationStyle.dotted,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 20),
                                      onPressed: () {
                                        BlocProvider.of<DoctorCubit>(context)
                                            .rejectAppointmentInterByDoctor(
                                                user[index]);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                    width: double.infinity,
                                    height: 3,
                                    color: ColorManager.containerColor),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 5,
                              ),
                          itemCount: user.length),
                    )
                  ]),
                ),
              ),
            );
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}

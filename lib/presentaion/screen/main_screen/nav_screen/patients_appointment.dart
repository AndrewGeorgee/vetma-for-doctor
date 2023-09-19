import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/reservation_details_entites.dart';

class PatientsAppointment extends StatefulWidget {
  const PatientsAppointment({super.key});

  @override
  State<PatientsAppointment> createState() => _PatientsAppointmentState();
}

class _PatientsAppointmentState extends State<PatientsAppointment>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  bool isContainerVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.prymaryColor,
      body: Column(
        children: [
          const SizedBox(height: 7),
          SafeArea(
              child: Text(
            'My Appointment',
            style: GoogleFonts.inter(
                fontSize: 30,
                color: Colors.white,
                decorationStyle: TextDecorationStyle.dotted,
                fontWeight: FontWeight.bold),
          )),
          const Spacer(),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            height: 650,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              TabBar.secondary(
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(text: 'Appointment Request'),
                  Tab(text: 'Toady Apointment'),
                ],
                labelColor: ColorManager.prymaryColor,
                dividerColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                indicator: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(20)),
                labelStyle: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.black,
                    decorationStyle: TextDecorationStyle.dotted,
                    fontWeight: FontWeight.w900),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Card(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request For Appointment',
                              style: GoogleFonts.inter(
                                  fontSize: 25,
                                  color: Colors.black,
                                  decorationStyle: TextDecorationStyle.dotted,
                                  fontWeight: FontWeight.w600),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('ReservationDetails')
                                  .where('doctorUid',
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .where('stetuse', isEqualTo: '')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final appointments = snapshot.data!.docs
                                      .map((doc) =>
                                          ReservationDetailsModel.fromSnapshot(
                                              doc))
                                      .toList();
                                  return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final app = appointments[index];

                                              return Visibility(
                                                visible: isContainerVisible,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: ColorManager.line),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      app.photoOfUser,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            35)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                app.nameOfUserReversation,
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .black,
                                                                    decorationStyle:
                                                                        TextDecorationStyle
                                                                            .dotted,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                app.appointment,
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .black,
                                                                    decorationStyle:
                                                                        TextDecorationStyle
                                                                            .dotted,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                app.date,
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .black,
                                                                    decorationStyle:
                                                                        TextDecorationStyle
                                                                            .dotted,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ]),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 40,
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                    color: ColorManager
                                                                        .switchColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          BlocProvider.of<DoctorCubit>(context)
                                                                              .accept(appointments[index]);
                                                                          setState(
                                                                              () {
                                                                            isContainerVisible =
                                                                                false;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Appoint',
                                                                          style: GoogleFonts.inter(
                                                                              fontSize: 17,
                                                                              color: Colors.white,
                                                                              decorationStyle: TextDecorationStyle.dotted,
                                                                              fontWeight: FontWeight.w300),
                                                                        )),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Container(
                                                                width: 80,
                                                                height: 40,
                                                                decoration: BoxDecoration(
                                                                    color: ColorManager
                                                                        .switchColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          BlocProvider.of<DoctorCubit>(context)
                                                                              .reject(appointments[index]);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Reject',
                                                                          style: GoogleFonts.inter(
                                                                              fontSize: 17,
                                                                              color: Colors.white,
                                                                              decorationStyle: TextDecorationStyle.dotted,
                                                                              fontWeight: FontWeight.w300),
                                                                        )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 5),
                                            itemCount: appointments.length),
                                      ));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('ReservationDetails')
                            .where('doctorUid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .where('stetuse', isEqualTo: 'accepted')
                            .where('day', isEqualTo: 'Today')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final appointments = snapshot.data!.docs
                                .map((doc) =>
                                    ReservationDetailsModel.fromSnapshot(doc))
                                .toList();

                            return Card(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Today Appointment',
                                      style: GoogleFonts.inter(
                                          fontSize: 25,
                                          color: Colors.black,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9),
                                      child: SingleChildScrollView(
                                        child: ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final app = appointments[index];

                                              return Container(
                                                width: double.infinity,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorManager
                                                        .prymaryColor,
                                                    width: 3.0,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0) //
                                                          ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          app.photoOfUser,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(app.nameOfUserReversation,
                                                              style: GoogleFonts.acme(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .black,
                                                                  decorationStyle:
                                                                      TextDecorationStyle
                                                                          .dotted,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(app.appointment,
                                                              style: GoogleFonts.acme(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  wordSpacing:
                                                                      2,
                                                                  decorationStyle:
                                                                      TextDecorationStyle
                                                                          .dotted,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(app.date,
                                                              style: GoogleFonts.acme(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  decorationStyle:
                                                                      TextDecorationStyle
                                                                          .dotted,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                            itemCount: appointments.length),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

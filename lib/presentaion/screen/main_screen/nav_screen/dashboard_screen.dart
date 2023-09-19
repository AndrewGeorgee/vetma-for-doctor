import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_of_vetma/core/resources/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/reservation_details_entites.dart';
import '../../../controller/mainCubit/doctor_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ReservationDetails')
                    .where('doctorUid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where('stetuse', isEqualTo: 'accepted')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final appointments = snapshot.data!.docs
                        .map((doc) => ReservationDetailsModel.fromSnapshot(doc))
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.bell),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Let’s Find Your\nAppointment Patient',
                          style: GoogleFonts.inter(
                              color: ColorManager.prymaryColor,
                              fontSize: 30,
                              decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: ColorManager.prymaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0) //
                                    ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Pattiont',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: Colors.white,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${appointments.length}",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: Colors.white,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: ColorManager.switchColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0) //
                                  ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Today Pattiont',
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: Colors.white,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 10),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('ReservationDetails')
                                          .where('doctorUid',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .where('day', isEqualTo: 'Today')
                                          .where('stetuse',
                                              isEqualTo: 'accepted')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final appointments = snapshot
                                              .data!.docs
                                              .map((doc) =>
                                                  ReservationDetailsModel
                                                      .fromSnapshot(doc))
                                              .toList();
                                          return Text(
                                            '${appointments.length}',
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: Colors.white,
                                                decorationStyle:
                                                    TextDecorationStyle.dotted,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          return const Center(child: Text('0'));
                                        }
                                      }),
                                ],
                              ),
                            ),
                          )),
                        ]),
                        const SizedBox(height: 30),
                        Text(
                          'Recently Appointed',
                          style: GoogleFonts.inter(
                              fontSize: 30,
                              color: Colors.black,
                              decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        SingleChildScrollView(
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final app = appointments[index];

                                return Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.prymaryColor,
                                      width: 3.0,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0) //
                                        ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  app.photoOfUser,
                                                ),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35)),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(app.nameOfUserReversation,
                                                style: GoogleFonts.inter(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .dotted,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(width: 10),
                                            Text(app.appointment,
                                                style: GoogleFonts.inter(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .dotted,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(width: 10),
                                            Text(app.date,
                                                style: GoogleFonts.inter(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .dotted,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 90,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  ColorManager.containerColor),
                                          child: TextButton(
                                              onPressed: () {
                                                BlocProvider.of<DoctorCubit>(
                                                        context)
                                                    .reject(
                                                        appointments[index]);
                                              },
                                              child: Text('Remove',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .dotted,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: appointments.length),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

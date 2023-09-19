import 'dart:developer';
import 'dart:io';

import 'package:doctor_of_vetma/data/models/doctor_model.dart';
import 'package:doctor_of_vetma/data/models/save_appointment_of_doctor.dart';
import 'package:doctor_of_vetma/presentaion/widget/tost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/reservation_details_entites.dart';
import 'base_remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataSource extends BaseRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final DateTime now;
  late final String day;
  
  @override
  Future<void> signUpDoctor(Doctors doctors) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: doctors.email!, password: doctors.password!);
  }

  @override
  Future<void> signInAsDoctor(Doctors doctors) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: doctors.email!,
        password: doctors.password!,
      );
      print('User registered: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> acceptAppointment(ReservationDetailsModel appointment) async {
    _firestore
        .collection('ReservationDetails')
        .doc(appointment.reservationUid)
        .update({
      'stetuse': 'accepted',
    }).asStream();
  }

  @override
  Future<void> rejectAppointment(ReservationDetailsModel appointment) async {
    await _firestore
        .collection('ReservationDetails')
        .doc(appointment.reservationUid)
        .delete();
  }

  @override
  Future<List<ReservationDetailsModel>> fetchReservationDetailsDoctor(
      String id) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('ReservationDetails')
        .where('doctorUid', isEqualTo: id)
        .get();
    return snapshot.docs
        .map((doc) => ReservationDetailsModel(
              appointment: doc['appointment'],
              stetuse: doc['stetuse'],
              priese: doc["priese"],
              day: doc['day'],
              userId: doc['userId'],
              date: doc['date'],
              doctorUid: doc['doctorUid'],
              nameOfDocotr: doc['nameOfDocotr'],
              nameOfUserReversation: doc['nameOfUserReversation'],
              photoOfUser: doc['photoOfUser'],
              reservationUid: doc['reservationUid'],
            ))
        .toList();
  }

  @override
  Future<void> getCreateCurrentDoctor(Doctors doctors) async {
    final userCollection = FirebaseFirestore.instance.collection('doctors');
    final uid = await getCurrentUId();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = Doctors(
        bio: doctors.bio,
        email: doctors.email,
        password: doctors.password,
        fee: doctors.fee,
        name: doctors.name,
        location: doctors.location,
        phote: doctors.phote,
        number: doctors.number,
        id: uid,
      ).toMap();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        userCollection.doc(uid).update(newUser);
        print("user already exist");
        return;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<String> getCurrentUId() async =>
      FirebaseAuth.instance.currentUser!.uid;
  @override
  Future<bool> isSignIn() async =>
      FirebaseAuth.instance.currentUser?.uid != null;

  @override
  Future<void> forgetPasssword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Stream<Doctors> getDoctorInfo(String uid) {
    return FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .snapshots()
        .map((doc) {
      return Doctors.fromJson(doc.data()!);
    });
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> getUpdateDoctor(Doctors user) async {
    Map<String, dynamic> userInformation = {};
    print(user.name);
    log(user.name!);
    final userCollection = FirebaseFirestore.instance.collection('doctors');

    if (user.phote != "") {
      userInformation['phote'] = user.phote;
    }
    if (user.name != "") {
      userInformation['name'] = user.name;
    }
    if (user.bio != "") {
      userInformation['bio'] = user.bio;
    }
    if (user.number != "") {
      userInformation["phoneNumber"] = user.number;
    }
    if (user.fee != "") {
      userInformation["fee"] = user.fee;
    }
    if (user.location != "") {
      userInformation['location'] = user.location;
    }

    userCollection.doc(user.id).update(userInformation);
  }

  @override
  Future<void> saveAppointment(AppointmentDoctor appointment) async {
    final CollectionReference appointmentsCollection =
        FirebaseFirestore.instance.collection('appointmentInterByDoctor');

    QuerySnapshot querySnapshot = await appointmentsCollection
        .where('dayOfAppointment', isEqualTo: appointment.dayOfAppointment)
        .where('timeOfAppointment', isEqualTo: appointment.timeOfAppointment)
        .where('idOfDoctor', isEqualTo: appointment.idOfDoctor)
        .where('idOfAppointment', isEqualTo: appointment.idOfAppointment)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print('Appointment already reserved at the specified date and time.');
      toast2('Appointment already reserved at the specified date and time.');
      return;
    }

    try {
      DocumentReference docRef = await appointmentsCollection.add({
        'idOfDoctor': appointment.idOfDoctor,
        'dayOfAppointment': appointment.dayOfAppointment,
        'timeOfAppointment': appointment.timeOfAppointment,
        'idOfAppointment': appointment.idOfAppointment
      });

      // ignore: unnecessary_null_comparison
      if (docRef.id != null) {
        String docId = docRef.id;
        appointment.idOfAppointment = docId;

        Map<String, dynamic> appointmentMap = appointment.toMap();
        await docRef.set(appointmentMap);
        toast('Appointment saved successfully!');
      } else {}
    } catch (e) {
      print('Error saving appointment: $e');
    }
  }

  @override
  Stream<List<AppointmentDoctor>> getAppointmentDoctorsStream() {
    return FirebaseFirestore.instance
        .collection('appointmentInterByDoctor')
        .where('idOfDoctor', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AppointmentDoctor.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> rejectAppointmentInterByDoctor(
      AppointmentDoctor appointment) async {
    await _firestore
        .collection('appointmentInterByDoctor')
        .doc(appointment.idOfAppointment)
        .delete();
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final uid = FirebaseAuth.instance.currentUser!.uid;

class StorageProviderRemoteDataSource {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadFile({required File file}) async {
    final ref = _storage.ref().child(
        "Documents/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}");

    final uploadTask = ref.putFile(file);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return await imageUrl;
  }

  static String getNameOnly(String path) {
    return path.split('/').last.split('%').last.split("?").first;
  }
}

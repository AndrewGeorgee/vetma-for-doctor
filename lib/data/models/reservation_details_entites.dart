import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ReservationDetailsModel extends Equatable {
  final String nameOfDocotr;
  final String priese;
  String? reservationUid;
  final String appointment;
  final String day;
  final String photoOfUser;
  final String payment;
  final String nameOfUserReversation;
  final String userId;
  final String doctorUid;
  final String date;
   String stetuse;

  ReservationDetailsModel(
      {this.nameOfDocotr = '',
      this.priese = '',
      required this.reservationUid,
      this.appointment = '',
      this.day = '',
      this.photoOfUser = '',
      this.payment = '',
      this.nameOfUserReversation = '',
      this.userId = '',
      this.doctorUid = '',
      this.date = '',
      required this.stetuse });

  factory ReservationDetailsModel.fromSnapshot(DocumentSnapshot json) {
    return ReservationDetailsModel(
      nameOfDocotr: json['nameOfDocotr'],
      stetuse: json['stetuse'],
      date: json['date'],
      priese: json['priese'],
      reservationUid: json['reservationUid'],
      appointment: json['appointment'],
      day: json['day'],
      photoOfUser: json['photoOfUser'],
      payment: json['payment'],
      nameOfUserReversation: json['nameOfUserReversation'],
      userId: json['userId'],
      doctorUid: json['doctorUid'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nameOfDocotr": nameOfDocotr,
      "stetuse": stetuse,
      "priese": priese,
      "reservationUid": reservationUid,
      "date": date,
      "appointment": appointment,
      "photoOfUser": photoOfUser,
      "day": day,
      "payment": payment,
      "nameOfUserReversation": nameOfUserReversation,
      "userId": userId,
      "doctorUid": doctorUid,
    };

    if (reservationUid != null) {
      reservationUid = map['reservationUid'];
      // map['reservationUid'] = reservationUid;
    }
    return map;
  }

  @override
  List<Object> get props => [
        nameOfDocotr,
        priese,
        reservationUid ?? '',
        appointment,
        stetuse ,
        photoOfUser,
        day,
        date,
        payment,
        nameOfDocotr,
        nameOfUserReversation,
        doctorUid,
      ];
}

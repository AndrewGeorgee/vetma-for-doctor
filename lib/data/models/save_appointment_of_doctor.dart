import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AppointmentDoctor extends Equatable {
  final String idOfDoctor;
  final String dayOfAppointment;
  final String timeOfAppointment;
   String ?idOfAppointment;

   AppointmentDoctor({
    this.idOfDoctor = '',
    this.dayOfAppointment = '',
    this.timeOfAppointment = '',
   required this.idOfAppointment,
  });

  factory AppointmentDoctor.fromSnapshot(DocumentSnapshot json) {
    return AppointmentDoctor(
      idOfDoctor: json['idOfDoctor'],
      dayOfAppointment: json['dayOfAppointment'],
      timeOfAppointment: json['timeOfAppointment'],
      idOfAppointment: json['idOfAppointment'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'idOfDoctor': idOfDoctor,
      'dayOfAppointment': dayOfAppointment,
      'timeOfAppointment': timeOfAppointment,
      'idOfAppointment': idOfAppointment,
    };
  }

  @override
  List<Object> get props => [
        idOfDoctor,
        timeOfAppointment,
        dayOfAppointment,
        idOfAppointment??'',
      ];
}

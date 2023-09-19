import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/doctor_model.dart';
import '../../data/models/reservation_details_entites.dart';
import '../../data/models/save_appointment_of_doctor.dart';

abstract class DoctorRepositery {
  Future<Either<Failure, void>> signUpDoctor(Doctors doctors);
  Future<Either<Failure, String>> getCurrentUId();
  Future<Either<Failure, void>> signInAsDoctor(Doctors user);
  Future<Either<Failure, void>> getCreateCurrentDoctor(Doctors doctors);
  Stream<Doctors> getDoctorInfStream(String userId);
  Future<Either<Failure, bool>> isSignIn();

  Future<Either<Failure, void>> forgetPassword(String emil);
  Future<Either<Failure, void>> getUpdateDoctor(Doctors user);
  Future<Either<Failure, void>> signOut();
  Future<List<ReservationDetailsModel>> fetchAppoinntmentToShow(String id);
  Future<Either<Failure, void>> acceptAppointment(
      ReservationDetailsModel appointment);
  Future<Either<Failure, void>> rejectAppointment(
      ReservationDetailsModel appointment);
  Future<Either<Failure, void>> saveAppointment(
      AppointmentDoctor appointmentDoctor);
  Stream<List<AppointmentDoctor>> getAppointmentRepo();
  Future<Either<Failure, void>> rejectAppointmentInterByDoctor(
      AppointmentDoctor appointment);
}

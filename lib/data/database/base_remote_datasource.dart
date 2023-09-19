import '../models/doctor_model.dart';
import '../models/reservation_details_entites.dart';
import '../models/save_appointment_of_doctor.dart';

abstract class BaseRemoteDataSource {
  Future<void> signUpDoctor(Doctors doctors);
  Future<void> signInAsDoctor(Doctors doctors);
  Future<void> getCreateCurrentDoctor(Doctors doctors);
  Future<String> getCurrentUId();
  Future<bool> isSignIn();
  Future<void> forgetPasssword(String email);
  Stream<Doctors> getDoctorInfo(String uid);
  Future<void> getUpdateDoctor(Doctors user);
  Future<void> signOut();
  Future<List<ReservationDetailsModel>> fetchReservationDetailsDoctor(
      String id);
  Future<void> rejectAppointment(ReservationDetailsModel appointment);
  Future<void> acceptAppointment(ReservationDetailsModel appointment);
  Future<void> saveAppointment(AppointmentDoctor appointment);
  Stream<List<AppointmentDoctor>> getAppointmentDoctorsStream();
  Future<void> rejectAppointmentInterByDoctor(AppointmentDoctor appointment);
}

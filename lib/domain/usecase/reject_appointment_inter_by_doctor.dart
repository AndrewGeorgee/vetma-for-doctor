import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/save_appointment_of_doctor.dart';
import '../repositery/vetma_repositery.dart';

class RejectAppointmentInterByDoctorUsecase {
  final DoctorRepositery repository;

  RejectAppointmentInterByDoctorUsecase(this.repository);

  Future<Either<Failure, void>> call(
      AppointmentDoctor appointmentDoctor) async {
    return await repository.rejectAppointmentInterByDoctor(appointmentDoctor);
  }
}

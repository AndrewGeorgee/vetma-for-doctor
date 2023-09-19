import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/save_appointment_of_doctor.dart';
import '../repositery/vetma_repositery.dart';

class SaveAppointmentUseCase {
  final DoctorRepositery repository;

  SaveAppointmentUseCase(this.repository);

   Future<Either<Failure, void>> call(AppointmentDoctor appointment) async {
    return await repository.saveAppointment(appointment);
  }
}

import 'package:doctor_of_vetma/domain/repositery/vetma_repositery.dart';

import '../../data/models/save_appointment_of_doctor.dart';

class GetAppointmentUsecase {
  final DoctorRepositery repository;

  GetAppointmentUsecase(this.repository);
  Stream<List<AppointmentDoctor>> call() {
    return repository.getAppointmentRepo();
  }
}

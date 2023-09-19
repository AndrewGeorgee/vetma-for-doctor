import '../../data/models/reservation_details_entites.dart';
import '../repositery/vetma_repositery.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
class AcceptAppointmentUsecase {
  final DoctorRepositery repository;

  AcceptAppointmentUsecase(this.repository);
  Future<Either<Failure, void>> call(ReservationDetailsModel appointment) async {
    return await repository.acceptAppointment(appointment);
  }
}

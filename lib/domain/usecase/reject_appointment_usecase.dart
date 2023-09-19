import '../../data/models/reservation_details_entites.dart';
import '../repositery/vetma_repositery.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
class RejectAppointmentUsecase {
  final DoctorRepositery repository;

  RejectAppointmentUsecase(this.repository);
    Future<Either<Failure, void>>call(ReservationDetailsModel appointment) async {
    return await repository.rejectAppointment(appointment);
  }
}

import '../../data/models/reservation_details_entites.dart';
import '../repositery/vetma_repositery.dart';

class FetchAppointmentOfDoctorUsecase {
  final DoctorRepositery repository;

  FetchAppointmentOfDoctorUsecase(this.repository);
  Future<List<ReservationDetailsModel>> call(String id) async {
    return await repository.fetchAppoinntmentToShow(id);
  }
}

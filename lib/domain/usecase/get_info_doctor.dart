import 'package:doctor_of_vetma/data/models/doctor_model.dart';

import '../repositery/vetma_repositery.dart';

class GetInformatrionOfDoctorUsecase {
  final DoctorRepositery repository;

  GetInformatrionOfDoctorUsecase(this.repository);
  Stream<Doctors> call(String uid) {
    return repository.getDoctorInfStream(uid);
  }
}

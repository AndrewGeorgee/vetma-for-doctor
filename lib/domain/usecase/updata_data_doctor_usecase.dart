import 'package:dartz/dartz.dart';
import 'package:doctor_of_vetma/data/models/doctor_model.dart';
import 'package:doctor_of_vetma/domain/repositery/vetma_repositery.dart';

import '../../core/error/failure.dart';

class GetUpdateDocotorUseCase {
  final DoctorRepositery repository;

  GetUpdateDocotorUseCase(this.repository);
 Future<Either<Failure, void>>  call(Doctors user) {
    return repository.getUpdateDoctor(user);
  }
}

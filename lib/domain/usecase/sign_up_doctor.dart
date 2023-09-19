import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/doctor_model.dart';
import '../repositery/vetma_repositery.dart';

class SignUpDocotrUseCase {
  final DoctorRepositery repository;

  SignUpDocotrUseCase(this.repository);

  Future<Either<Failure, void>> call(Doctors doctors) async {
    return await repository.signUpDoctor(doctors);
  }
}

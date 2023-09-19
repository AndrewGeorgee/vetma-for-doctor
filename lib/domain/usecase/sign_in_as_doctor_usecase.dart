import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/doctor_model.dart';
import '../repositery/vetma_repositery.dart';

class SigninAsDoctorUseCase {
  final DoctorRepositery repository;

  SigninAsDoctorUseCase(this.repository);

  Future<Either<Failure, void>> call(Doctors user) async {
    return await repository.signInAsDoctor(user);
  }
}

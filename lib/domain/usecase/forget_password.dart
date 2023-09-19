import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositery/vetma_repositery.dart';

class ForgetPasswordUseCAse {
  final DoctorRepositery repository;

  ForgetPasswordUseCAse(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    return await repository.forgetPassword(email);
  }
}
 
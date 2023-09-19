import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositery/vetma_repositery.dart';


class IsSignInUseCase {
  final DoctorRepositery repository;

  IsSignInUseCase(this.repository);

  Future<Either<Failure, bool>>  call() {
    return repository.isSignIn();
  }
}

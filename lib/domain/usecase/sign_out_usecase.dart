import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositery/vetma_repositery.dart';

class SignOutUseCase {
  final DoctorRepositery repository;

  SignOutUseCase(this.repository);

 Future<Either<Failure, void>>  call() async {
    return repository.signOut();
  }
}

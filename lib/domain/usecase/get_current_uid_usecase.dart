import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositery/vetma_repositery.dart';

class GetCurrentUIDUseCase {
  final DoctorRepositery repository;

  GetCurrentUIDUseCase(this.repository);
  Future<Either<Failure, String>> call() async {
    return await repository.getCurrentUId();
  }
}

import 'package:dartz/dartz.dart';

import 'package:doctor_of_vetma/core/error/failure.dart';
import 'package:doctor_of_vetma/data/models/doctor_model.dart';
import 'package:doctor_of_vetma/data/models/save_appointment_of_doctor.dart';

import '../../core/error/exceptions.dart';
import '../../domain/repositery/vetma_repositery.dart';
import '../database/base_remote_datasource.dart';
import '../models/reservation_details_entites.dart';

class DoctorReposittory implements DoctorRepositery {
  final BaseRemoteDataSource baseRemoteDataSourse;

  DoctorReposittory(this.baseRemoteDataSourse);

  @override
  Future<Either<Failure, void>> getCreateCurrentDoctor(Doctors doctors) async {
    final r = await baseRemoteDataSourse.getCreateCurrentDoctor(doctors);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUId() async {
    final r = await baseRemoteDataSourse.getCurrentUId();
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> signInAsDoctor(Doctors user) async {
    final r = await baseRemoteDataSourse.signInAsDoctor(user);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> signUpDoctor(Doctors doctors) async {
    final r = await baseRemoteDataSourse.signUpDoctor(doctors);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignIn() async {
    final r = await baseRemoteDataSourse.isSignIn();
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    final r = await baseRemoteDataSourse.forgetPasssword(email);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Stream<Doctors> getDoctorInfStream(String userId) {
    return baseRemoteDataSourse.getDoctorInfo.call(userId);
  }

  @override
  Future<Either<Failure, void>> getUpdateDoctor(Doctors user) async {
    final r = await baseRemoteDataSourse.getUpdateDoctor(user);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final r = await baseRemoteDataSourse.signOut();
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<List<ReservationDetailsModel>> fetchAppoinntmentToShow(
      String id) async {
    return await baseRemoteDataSourse.fetchReservationDetailsDoctor(id);
  }

  @override
  Future<Either<Failure, void>> acceptAppointment(
      ReservationDetailsModel appointment) async {
    final r = await baseRemoteDataSourse.acceptAppointment(appointment);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> rejectAppointment(
      ReservationDetailsModel appointment) async {
    final r = await baseRemoteDataSourse.rejectAppointment(appointment);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> saveAppointment(
      AppointmentDoctor appointmentDoctor) async {
    final r = await baseRemoteDataSourse.saveAppointment(appointmentDoctor);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Stream<List<AppointmentDoctor>> getAppointmentRepo() {
    return baseRemoteDataSourse.getAppointmentDoctorsStream();
  }

  @override
  Future<Either<Failure, void>> rejectAppointmentInterByDoctor(
      AppointmentDoctor appointment) async{
    final r =await baseRemoteDataSourse.rejectAppointmentInterByDoctor(appointment);
    try {
      return Right(r);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}

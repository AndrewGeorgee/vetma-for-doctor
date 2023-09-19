// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:doctor_of_vetma/domain/usecase/is_sign_in_usecase.dart';
import 'package:doctor_of_vetma/domain/usecase/reject_appointment_usecase.dart';
import 'package:doctor_of_vetma/domain/usecase/save_appointment.dart';
import 'package:doctor_of_vetma/domain/usecase/sign_in_as_doctor_usecase.dart';
import 'package:doctor_of_vetma/domain/usecase/updata_data_doctor_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/models/reservation_details_entites.dart';
import '../../../data/models/save_appointment_of_doctor.dart';
import '../../../domain/usecase/accept_appointment_usecase.dart';
import '../../../domain/usecase/fetch_appointment_of_show_im_doctor_usecase.dart';
import '../../../domain/usecase/forget_password.dart';
import '../../../domain/usecase/get_appointment_usecase.dart';
import '../../../domain/usecase/get_create_information_doctor_usecase.dart';
import '../../../domain/usecase/get_current_uid_usecase.dart';
import '../../../domain/usecase/get_info_doctor.dart';
import '../../../domain/usecase/reject_appointment_inter_by_doctor.dart';
import '../../../domain/usecase/sign_out_usecase.dart';
import '../../../domain/usecase/sign_up_doctor.dart';
import 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final SigninAsDoctorUseCase signinAsDoctorUseCase;
  final SignUpDocotrUseCase signUpDocotrUseCase;
  final GetCurrentUIDUseCase getCurrentUIDUseCase;
  final SignOutUseCase signOutUseCase;
  final FetchAppointmentOfDoctorUsecase fetchAppointmentOfDoctorUsecase;
  final IsSignInUseCase isSignInUseCase;
  final AcceptAppointmentUsecase acceptAppointmentUsecase;
  final RejectAppointmentUsecase rejectAppointmentUsecase;
  final ForgetPasswordUseCAse forgotPasswordUseCase;
  final GetInformatrionOfDoctorUsecase getDoctorInfUSecase;
  final GetUpdateDocotorUseCase getUpdateUsecase;
  //final CreateNewReservationDetailsEntity createResDetEntitie
  final SaveAppointmentUseCase saveAppointmentUseCase;
  final GetAppointmentUsecase getAppointmentUsecase;
  final RejectAppointmentInterByDoctorUsecase
      rejectAppointmentInterByDoctorUsecase;

  final GetCreateCurrentDocotrUseCase getCreateCurrentDocotrUseCase;
  DoctorCubit({
    required this.signinAsDoctorUseCase,
    required this.signUpDocotrUseCase,
    required this.getAppointmentUsecase,
    required this.fetchAppointmentOfDoctorUsecase,
    required this.acceptAppointmentUsecase,
    required this.rejectAppointmentUsecase,
    required this.rejectAppointmentInterByDoctorUsecase,
    required this.getCurrentUIDUseCase,
    required this.getUpdateUsecase,
    required this.getCreateCurrentDocotrUseCase,
    required this.saveAppointmentUseCase,
    required this.signOutUseCase,
    required this.forgotPasswordUseCase,
    required this.getDoctorInfUSecase,
    required this.isSignInUseCase,
  }) : super(CredentialInitial());

  static DoctorCubit get(context) => BlocProvider.of(context);

  Future<void> signInAsDoctorSubmit({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    final result = await signinAsDoctorUseCase
        .call(Doctors(email: email, password: password));

    result.fold(
      (failure) => emit(CredentialFailure(failure.toString())),
      (right) async {
        final getCurrentUIDResult = await getCurrentUIDUseCase.call();
        getCurrentUIDResult.fold(
          (failure) => emit(CredentialFailure(failure.toString())),
          (right) => emit(const CredentialSuccess()),
        );
      },
    );
  }

  Future<void> saveAppointment(AppointmentDoctor appointmentDoctor) async {
    emit(SaveAppointmentLoadind());

    try {
      final result = await saveAppointmentUseCase.call(AppointmentDoctor(
        dayOfAppointment: appointmentDoctor.dayOfAppointment,
        idOfDoctor: FirebaseAuth.instance.currentUser!.uid,
        timeOfAppointment: appointmentDoctor.timeOfAppointment,
        idOfAppointment: appointmentDoctor.idOfAppointment
      ));

      result.fold(
        (failure) => emit(SaveAppointmentError()),
        (_) => emit(SaveAppointmentLoadied()),
      );
    } on SocketException catch (_) {
      emit(SaveAppointmentError());
    } catch (_) {
      emit(SaveAppointmentError());
    }
  }

  Future<void> loggedOut() async {
    final result = await signOutUseCase.call();
    result.fold(
        (l) => emit(UnAuthenticated()), (r) => emit(LogOutStateSussed()));
  }

  Future<void> signUpDoctrSubmit({required Doctors doctors}) async {
    emit(CredentialLoading());
    final result = await signUpDocotrUseCase
        .call(Doctors(email: doctors.email, password: doctors.password));

    result.fold(
      (failure) => emit(CredentialFailure(failure.toString())),
      (right) async {
        final createResult = await getCreateCurrentDocotrUseCase.call(doctors);
        createResult.fold(
          (failure) => emit(CredentialFailure(failure.toString())),
          (right) => emit(const CredentialSuccess()),
        );
      },
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    final result = await forgotPasswordUseCase.call(email);
    result.fold((l) => emit(ForgetPasswordError(l.toString())),
        (r) => emit(ForgetPasswordSuussed()));
  }

  Doctors? doctor;
  Stream<Doctors> getInformation(String doctor) {
    return getDoctorInfUSecase.call(doctor);
  }

  Stream<List<AppointmentDoctor>> getAppointmentCubit() {
    return getAppointmentUsecase.call();
  }
  // void getUserData() {
  //   emit(SocialGetUserLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('doctors')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     doctor = Doctors.fromJson(value.data()!);
  //     emit(SocialGetUserloadedState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialGetUserErrorState());
  //   });
  // }

  Future<void> getUpdateUser({required Doctors user}) async {
    try {
      await getUpdateUsecase.call(user);
    } on SocketException catch (_) {
      emit(const CredentialSuccess());
    } catch (e) {
      emit(CredentialFailure(e.toString()));
    }
  }

  // void fetchAppointmentt(String idofDoctor) {
  //   emit(DoctorAppointmentLoading());
  //   try {
  //     final app = fetchAppointmentOfDoctorUsecase.call(idofDoctor);
  //     // log(${app.length} );
  //     // print(${app.length})
  //     emit(DoctorAppointmentSussedd(app as List<ReservationDetailsModel>));
  //   } on SocketException catch (_) {
  //     emit(DoctorAppointmentError());
  //   } catch (_) {
  //     emit(DoctorAppointmentError());
  //   }
  // }

  Future<void> accept(
    ReservationDetailsModel reservationDetailsModel,
  ) async {
    emit(AcceotAppointmentLoading());
    try {
      final result =
          await acceptAppointmentUsecase.call(reservationDetailsModel);
      result.fold(
        (failure) => emit(AcceotAppointmentError()),
        (_) => emit(AcceotAppointmentSussed()),
      );
    } on SocketException catch (_) {
      emit(AcceotAppointmentError());
    } catch (_) {
      emit(AcceotAppointmentError());
    }
  }

  Future<void> reject(ReservationDetailsModel reservationDetailsModel) async {
    emit(RejectAppointmentLoading());
    try {
      final result =
          await rejectAppointmentUsecase.call(reservationDetailsModel);
      result.fold(
        (failure) => emit(RejectAppointmentError(failure.toString())),
        (_) => emit(RejectAppointmentSussed()),
      );
    } on SocketException catch (e) {
      emit(RejectAppointmentError(e.toString()));
    } catch (e) {
      emit(RejectAppointmentError(e.toString()));
    }
  }

  Future<void> rejectAppointmentInterByDoctor(
      AppointmentDoctor appointmentDoctor) async {
    emit(RejectAppointmentLoading());
    try {
      final result =
          await rejectAppointmentInterByDoctorUsecase.call(appointmentDoctor);
      result.fold(
        (failure) => emit(RejectAppointmentError(failure.toString())),
        (_) => emit(RejectAppointmentSussed()),
      );
    } on SocketException catch (e) {
      emit(RejectAppointmentError(e.toString()));
    } catch (e) {
      emit(RejectAppointmentError(e.toString()));
    }
  }
}

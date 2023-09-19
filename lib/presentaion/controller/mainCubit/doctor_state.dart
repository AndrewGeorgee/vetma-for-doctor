import 'package:doctor_of_vetma/data/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/reservation_details_entites.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();
}

class CredentialInitial extends DoctorState {
  @override
  List<Object> get props => [];
}

class CredentialLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class CredentialSuccess extends DoctorState {
  const CredentialSuccess();
  @override
  List<Object> get props => [];
}

class CredentialFailure extends DoctorState {
  final String message;

  const CredentialFailure(this.message);
  @override
  List<Object> get props => [
        message,
      ];
}

class CredentialGetDataUserLoading extends DoctorState {
  const CredentialGetDataUserLoading();
  @override
  List<Object> get props => [];
}

class CredentialGetDataUserSuccess extends DoctorState {
  const CredentialGetDataUserSuccess();
  @override
  List<Object> get props => [];
}

class CredentialGetDataUserError extends DoctorState {
  final String message;

  const CredentialGetDataUserError(this.message);
  @override
  List<Object> get props => [message];
}

class AuthLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class Authenticated extends DoctorState {
  final String uid;

  const Authenticated({required this.uid});
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends DoctorState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoading extends DoctorState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuussed extends DoctorState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordError extends DoctorState {
  final String massage;

  const ForgetPasswordError(this.massage);
  @override
  List<Object?> get props => [massage];
}

class GetDoctorInformationLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class GetDoctorInformationSuccess extends DoctorState {
  final Doctors doctor;

  const GetDoctorInformationSuccess(this.doctor);
  @override
  List<Object> get props => [doctor];
}

class GetDoctorInformationError extends DoctorState {
  final String massage;

  const GetDoctorInformationError(this.massage);
  @override
  List<Object> get props => [massage];
}

class LogOutStateSussed extends DoctorState {
  @override
  List<Object?> get props => [];
}

class LogOutStateError extends DoctorState {
  @override
  List<Object> get props => [];
}

class LogOutStateLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class DoctorAppointmentLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class DoctorAppointmentSussedd extends DoctorState {
  final List<ReservationDetailsModel> model;

  const DoctorAppointmentSussedd(this.model);

  @override
  List<Object> get props => [model];
}

class DoctorAppointmentError extends DoctorState {
  @override
  List<Object> get props => [];
}

class GetDoctorAppointmentSuccess extends DoctorState {
  final ReservationDetailsModel doctor;

  const GetDoctorAppointmentSuccess(this.doctor);
  @override
  List<Object> get props => [doctor];
}

class AcceotAppointmentLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class AcceotAppointmentSussed extends DoctorState {
  @override
  List<Object> get props => [];
}

class AcceotAppointmentError extends DoctorState {
  @override
  List<Object> get props => [];
}

class RejectAppointmentLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

class RejectAppointmentSussed extends DoctorState {
  @override
  List<Object> get props => [];
}

class RejectAppointmentError extends DoctorState {
  final String error;

  RejectAppointmentError(this.error);
  @override
  List<Object> get props => [error];
}

class SaveAppointmentLoadind extends DoctorState {
  @override
  List<Object?> get props => [];
}

class SaveAppointmentLoadied extends DoctorState {
  @override
  List<Object?> get props => [];
}

class SaveAppointmentError extends DoctorState {
  @override
  List<Object?> get props => [];
}

class SocialGetUserLoadingState extends DoctorState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SocialGetUserloadedState extends DoctorState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SocialGetUserErrorState extends DoctorState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

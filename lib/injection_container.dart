import 'package:doctor_of_vetma/domain/usecase/get_appointment_usecase.dart';
import 'package:doctor_of_vetma/domain/usecase/is_sign_in_usecase.dart';
import 'package:doctor_of_vetma/domain/usecase/sign_out_usecase.dart';
import 'package:doctor_of_vetma/domain/usecase/sign_up_doctor.dart';
import 'package:doctor_of_vetma/presentaion/controller/auth/auth_cubit.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/database/base_remote_datasource.dart';
import 'data/database/remote_data_source.dart';
import 'data/repository/impl_repository.dart';
import 'domain/repositery/vetma_repositery.dart';
import 'domain/usecase/accept_appointment_usecase.dart';
import 'domain/usecase/fetch_appointment_of_show_im_doctor_usecase.dart';
import 'domain/usecase/forget_password.dart';
import 'domain/usecase/get_create_information_doctor_usecase.dart';
import 'domain/usecase/get_current_uid_usecase.dart';
import 'domain/usecase/get_info_doctor.dart';
import 'domain/usecase/reject_appointment_inter_by_doctor.dart';
import 'domain/usecase/reject_appointment_usecase.dart';
import 'domain/usecase/save_appointment.dart';
import 'domain/usecase/sign_in_as_doctor_usecase.dart';
import 'domain/usecase/updata_data_doctor_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator {
  init() async {
    sl.registerFactory(
      () => DoctorCubit(
        getCurrentUIDUseCase: sl(),
        acceptAppointmentUsecase: sl(),
        signUpDocotrUseCase: sl(),
        getAppointmentUsecase: sl(),
        getDoctorInfUSecase: sl(),
        fetchAppointmentOfDoctorUsecase: sl(),
        signOutUseCase: sl(),
        signinAsDoctorUseCase: sl(),
        isSignInUseCase: sl(),
        getUpdateUsecase: sl(),
        rejectAppointmentUsecase: sl(),
        forgotPasswordUseCase: sl(),
        getCreateCurrentDocotrUseCase: sl(),
        saveAppointmentUseCase: sl(),
        rejectAppointmentInterByDoctorUsecase: sl(),
      ),
    );
    sl.registerFactory(
      () => AuthCubit(
        getCurrentUIDUseCase: sl(),
        signOutUseCase: sl(),
        isSignInUseCase: sl(),
      ),
    );

    /// Use Cases
    sl.registerLazySingleton(() => GetCreateCurrentDocotrUseCase(sl()));
    sl.registerLazySingleton(() => GetCurrentUIDUseCase(sl()));
    sl.registerLazySingleton(() => SigninAsDoctorUseCase(sl()));
    sl.registerLazySingleton(() => SignUpDocotrUseCase(sl()));
    sl.registerLazySingleton(() => GetUpdateDocotorUseCase(sl()));
    sl.registerLazySingleton(() => IsSignInUseCase(sl()));
    sl.registerLazySingleton(() => FetchAppointmentOfDoctorUsecase(sl()));
    sl.registerLazySingleton(() => SignOutUseCase(sl()));
    sl.registerLazySingleton(() => AcceptAppointmentUsecase(sl()));
    sl.registerLazySingleton(() => RejectAppointmentUsecase(sl()));
    sl.registerLazySingleton(() => SaveAppointmentUseCase(sl()));
    sl.registerLazySingleton(() => GetAppointmentUsecase(sl()));
    sl.registerLazySingleton(() => RejectAppointmentInterByDoctorUsecase(sl()));

    sl.registerLazySingleton(() => ForgetPasswordUseCAse(sl()));
    sl.registerLazySingleton(() => GetInformatrionOfDoctorUsecase(sl()));

    /// Repository
    sl.registerLazySingleton<DoctorRepositery>(() => DoctorReposittory(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  }
}

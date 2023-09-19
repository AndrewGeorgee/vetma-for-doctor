import 'package:bloc/bloc.dart';

import '../../../../domain/usecase/get_current_uid_usecase.dart';
import '../../../../domain/usecase/is_sign_in_usecase.dart';
import '../../../../domain/usecase/sign_out_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUIDUseCase getCurrentUIDUseCase;

  AuthCubit(
      {required this.isSignInUseCase,
      required this.signOutUseCase,
      required this.getCurrentUIDUseCase})
      : super(AuthInitial());
  Future<void> appStarted() async {
    final result = await isSignInUseCase.call();

    result.fold(
      (failure) => emit(UnAuthenticated()),
      (isSignIn) async {
        if (isSignIn == true) {
          final getCurrentUIDResult = await getCurrentUIDUseCase.call();
          getCurrentUIDResult.fold(
            (failure) => emit(UnAuthenticated()),
            (r) => emit(Authenticated(uid: r)),
          );
        }
      },
    );
  }
}

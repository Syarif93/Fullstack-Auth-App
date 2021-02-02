import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ci4_flutter/repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    final userLogin = await _authRepository.userLogin(email, password);
    // print(userLogin.token);

    if (userLogin.token?.isEmpty ?? true) {
      emit(LoginFail());
    } else {
      emit(LoginSuccess(token: userLogin.token));
    }
  }
}

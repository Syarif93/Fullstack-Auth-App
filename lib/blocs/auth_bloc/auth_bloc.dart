import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ci4_flutter/models/auth/auth_model.dart';
import 'package:ci4_flutter/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStart) {
      yield* _mapAuthStartToState();
    }

    if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedInToProps(token: event.token);
    }

    if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutToProps();
    }
  }

  Stream<AuthState> _mapAuthStartToState() async* {
    final isSignedIn = await _authRepository.hasToken();

    if (isSignedIn != null) {
      final userData = await _authRepository.getUserData(token: isSignedIn);

      yield AuthHasToken(
          id: userData.id,
          name: userData.name,
          email: userData.email,
          createdAt: userData.createdAt);
    } else {
      yield AuthFail();
    }
  }

  Stream<AuthState> _mapAuthLoggedInToProps({String token}) async* {
    if (token != null) {
      await _authRepository.setToken(token);

      final userData = await _authRepository.getUserData(token: token);

      yield AuthHasToken(
        id: userData.id,
        name: userData.name,
        email: userData.email,
        createdAt: userData.createdAt,
      );
    }

    yield AuthFail();
  }

  Stream<AuthState> _mapAuthLoggedOutToProps() async* {
    await _authRepository.removeToken();

    yield AuthFail();
  }
}

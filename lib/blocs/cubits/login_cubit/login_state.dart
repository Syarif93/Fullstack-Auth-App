part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFail extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({this.token});

  @override
  List<Object> get props => [token];
}

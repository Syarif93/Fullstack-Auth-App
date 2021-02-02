part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthHasToken extends AuthState {
  final String id;
  final String name;
  final String email;
  final String createdAt;

  AuthHasToken({this.id, this.name, this.email, this.createdAt});

  @override
  List<Object> get props => [
        {"id": id, "name": name, "email": email, "createdAt": createdAt}
      ];
}

class AuthFail extends AuthState {}

class AuthGetUserData extends AuthState {
  final UserDataModel user;

  AuthGetUserData({this.user});

  @override
  List<Object> get props => [user];
}

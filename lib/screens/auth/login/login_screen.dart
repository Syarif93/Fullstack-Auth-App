import 'package:ci4_flutter/blocs/cubits/login_cubit/login_cubit.dart';
import 'package:ci4_flutter/repositories/auth/auth_repository.dart';
import 'package:ci4_flutter/screens/auth/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  const LoginScreen({Key key, AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(authRepository: _authRepository),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: LoginForm(
                authRepository: _authRepository,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

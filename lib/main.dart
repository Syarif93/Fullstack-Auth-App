import 'package:ci4_flutter/blocs/simple_bloc_observer.dart';
import 'package:ci4_flutter/repositories/auth/auth_repository.dart';
import 'package:ci4_flutter/screens/auth/login/login_screen.dart';
import 'package:ci4_flutter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth_bloc/auth_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final AuthRepository authRepository = AuthRepository();

  runApp(BlocProvider(
    create: (_) => AuthBloc(
      authRepository: authRepository,
    )..add(AuthStart()),
    child: MyApp(
      authRepository: authRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;

  const MyApp({Key key, AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Codeigniter 4 + Flutter App ",
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFail) {
            return LoginScreen(authRepository: _authRepository);
          }

          if (state is AuthHasToken) {
            return HomeScreen(authRepository: _authRepository);
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

import 'package:ci4_flutter/blocs/auth_bloc/auth_bloc.dart';
import 'package:ci4_flutter/blocs/cubits/login_cubit/login_cubit.dart';
import 'package:ci4_flutter/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final AuthRepository _authRepository;

  const LoginForm({Key key, AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController =
      TextEditingController(text: "moh.syarif93@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "12345678");

  LoginCubit _loginCubit;

  // bool isButtonEnabled(LoginState state) {
  //   return !state.isSubmitting;
  // }

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging In...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state is LoginFail) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state is LoginSuccess) {
          BlocProvider.of<AuthBloc>(context)
              .add(AuthLoggedIn(token: state.token));
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        cubit: _loginCubit,
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Passwrod"),
            ),
            RaisedButton(
              onPressed: () {
                _handleSubmit();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    _loginCubit.login(_emailController.text, _passwordController.text);
  }
}

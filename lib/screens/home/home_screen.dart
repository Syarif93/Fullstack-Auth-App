import 'package:ci4_flutter/blocs/auth_bloc/auth_bloc.dart';
import 'package:ci4_flutter/models/auth/auth_model.dart';
import 'package:ci4_flutter/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final AuthRepository _authRepository;

  const HomeScreen({
    Key key,
    AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthRepository get authRepository => widget._authRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthHasToken) {
            return Column(
              children: [
                Text("id: ${state.id}"),
                Text("name: ${state.name}"),
                Text("email: ${state.email}"),
                Text("createdAt: ${state.createdAt}"),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLoggedOut());
                  },
                  child: Text("Logout"),
                )
              ],
            );
          }

          return Text("user not found");
        }),
      ),
    );
  }
}

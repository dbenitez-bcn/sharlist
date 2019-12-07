import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';
import 'package:sharlist/presentation/bloc/auth/auth_event.dart';

class SignInAnonymouslyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: Key('signInAnonymouslyButton'),
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(SignInAnonymouslyEvent());
      },
      child: Text('Acceder sin iniciar sesion'),
    );
  }
}

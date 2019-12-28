import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlist/core/injection_container.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';
import 'package:sharlist/presentation/widgets/sign_in_anonymous_button.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        builder: (_) => sl<AuthBloc>(),
        child: Column(
          children: <Widget>[
            SizedBox(),
            Column(),
            SignInAnonymouslyButton()
          ],
        ),
      )
    );
  }
}

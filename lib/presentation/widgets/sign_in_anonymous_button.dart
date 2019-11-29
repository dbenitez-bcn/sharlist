import 'package:flutter/material.dart';
import 'package:sharlist/core/injection_container.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';

class SignInAnonymouslyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: Key('signInAnonymouslyButton'),
      onPressed: _signIn,
      child: Text('Acceder sin iniciar sesion'),
    );
  }

  void _signIn() {
    final useCase = sl<SignInAnonymously>();
    useCase();
  }
}

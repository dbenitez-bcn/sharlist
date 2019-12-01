import 'package:flutter/material.dart';
import 'package:sharlist/presentation/widgets/sign_in_anonymous_button.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInAnonymouslyButton(),
    );
  }
}

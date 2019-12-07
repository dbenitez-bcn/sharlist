import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlist/core/injection_container.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';
import 'package:sharlist/presentation/bloc/auth/auth_event.dart';
import 'package:sharlist/presentation/bloc/auth/auth_state.dart';
import 'package:sharlist/presentation/widgets/sign_in_anonymous_button.dart';

import 'core/constants.dart';

void mainApp() {
  setUpDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '${Constants.APP_NAME}',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        //home: Scaffold(body: Center(child: Text('${Constants.APP_NAME}')))
        home: MyHomePage(title: '${Constants.APP_NAME}'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BlocProvider(
        builder: (_) => sl<AuthBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                // Top half
                Container(
                    // Third of the size of the screen
                    height: MediaQuery.of(context).size.height / 3,
                    // Message Text widgets / CircularLoadingIndicator
                    child: new AuthBlocBuilder()),
                SizedBox(height: 20),
                // Bottom half
                Column(
                  children: <Widget>[
                    // TextField
                    Placeholder(fallbackHeight: 40),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          // Search concrete button
                          child: SignInAnonymouslyButton(),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          // Random button
                          child: new GoogleButton(),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthBlocBuilder extends StatelessWidget {
  const AuthBlocBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Empty)
          return Text("Sign in!");
        else if (state is Loading)
          return CircularProgressIndicator();
        else if (state is Loaded)
          return Text(state.user.uid);
        else if (state is Error) return Text(state.message);
        return Container();
      },
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Google'),
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
      },
    );
  }
}

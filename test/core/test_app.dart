import 'package:flutter/material.dart';

class TestApp extends StatefulWidget {
  final Widget widget;

  TestApp(this.widget);

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: widget.widget);
  }
}

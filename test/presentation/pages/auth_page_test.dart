import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharlist/presentation/pages/auth_page.dart';

import '../../core/test_app.dart';

void main() {
  testWidgets('should have a signInAnonymousButton', (WidgetTester tester) async {
    // Arrange
    final AuthPage page = AuthPage();
    // Act
    await tester.pumpWidget(TestApp(page));
    // Assert
    expect(find.byKey(Key('signInAnonymouslyButton')), findsOneWidget);
  });
}
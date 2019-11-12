import 'package:flutter_test/flutter_test.dart';

void main() {
  final testUser = SharlistUserModel(id: "uid", role: Role.user);

  test('should be a subclass a SharlistUser entity', () async {
    // Assert
    expect(testUser, is<SharlistUser>());
  });
}

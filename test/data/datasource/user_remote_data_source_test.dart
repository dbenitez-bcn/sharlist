import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/core/constants.dart';
import 'package:sharlist/data/datasources/user_remote_data_source.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/data/models/sharlist_user_model.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements AuthResult {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockFirestore extends Mock implements Firestore {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockCollectionReference extends Mock implements CollectionReference {}

void main() {
  UserRemoteDataSource dataSource;
  MockFirebaseAuth mockAuth;
  MockAuthResult mockAuthResult;
  MockFirebaseUser mockFirebaseUser;
  MockFirestore mockFirestore;
  MockCollectionReference mockDatabaseCollection;
  MockDocumentReference mockEnvironmentDocument;
  MockCollectionReference mockUsersCollection;
  MockDocumentReference mockUserDocument;
  MockDocumentSnapshot mockUserSnapshot;

  final String uid = 'test uid';
  final SharlistUser expectedUser =
      SharlistUserModel(uid: uid, role: Role.user);
  Constants.setEnvironment(Environment.DEV);
  final userJson = {'uid': uid, 'role': 'user'};

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockAuthResult = MockAuthResult();
    mockFirebaseUser = MockFirebaseUser();
    mockFirestore = MockFirestore();
    mockDatabaseCollection = MockCollectionReference();
    mockEnvironmentDocument = MockDocumentReference();
    mockUsersCollection = MockCollectionReference();
    mockUserDocument = MockDocumentReference();
    mockUserSnapshot = MockDocumentSnapshot();
    dataSource =
        UserRemoteDataSourceImpl(auth: mockAuth, firestore: mockFirestore);
  });

  group('User data source', () {
    group('Anonymous sign in way', () {
      test(
          'should return create a user on the database and return a sharlist user when getAnonymousUser is called',
          () async {
        // Arrange
        when(mockFirebaseUser.uid).thenReturn(uid);
        when(mockAuthResult.user).thenReturn(mockFirebaseUser);
        when(mockAuth.signInAnonymously())
            .thenAnswer((_) async => mockAuthResult);
        when(mockFirestore.collection(any)).thenReturn(mockDatabaseCollection);
        when(mockDatabaseCollection.document(any))
            .thenReturn(mockEnvironmentDocument);
        when(mockEnvironmentDocument.collection(any))
            .thenReturn(mockUsersCollection);
        when(mockUsersCollection.document(any)).thenReturn(mockUserDocument);
        when(mockUserDocument.get()).thenAnswer((_) async => mockUserSnapshot);
        when(mockUserSnapshot.data).thenReturn(userJson);

        // Act
        final result = await dataSource.getAnonymousUser();

        // Assert
        verify(mockAuth.signInAnonymously());
        verify(mockUserDocument.setData(userJson));
        verify(mockUserDocument.get());
        verifyNoMoreInteractions(mockAuth);
        expect(result, expectedUser);
      });
    });
  });
}

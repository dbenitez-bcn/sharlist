import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import 'package:sharlist/core/constants.dart';
import 'package:sharlist/core/error/exceptions.dart';
import 'package:sharlist/data/datasources/user_remote_data_source.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/data/models/sharlist_user_model.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

// TODO Extract this mocks
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements AuthResult {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockFirestore extends Mock implements Firestore {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockFacebookLogin extends Mock implements FacebookLogin {}

class MockFacebookLoginResult extends Mock implements FacebookLoginResult {}

class MockFacebookToken extends Mock implements FacebookAccessToken {}

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
  MockGoogleSignIn mockGoogleSignIn;
  MockGoogleSignInAccount mockGoogleSignInAccount;
  MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  MockFacebookLogin mockFacebookLogin;
  MockFacebookLoginResult mockFacebookLoginResult;
  MockFacebookToken mockFacebookToken;

  final String uid = 'test uid';
  final SharlistUser expectedUser =
      SharlistUserModel(uid: uid, role: Role.user);
  Constants.setEnvironment(Environment.DEV);
  final userJson = {'uid': uid, 'role': 'user'};
  final String accessToken = 'access token test';
  final String idToken = 'id token test';

  void _setUpMocks() {
    mockAuth = MockFirebaseAuth();
    mockAuthResult = MockAuthResult();
    mockFirebaseUser = MockFirebaseUser();
    mockFirestore = MockFirestore();
    mockDatabaseCollection = MockCollectionReference();
    mockEnvironmentDocument = MockDocumentReference();
    mockUsersCollection = MockCollectionReference();
    mockUserDocument = MockDocumentReference();
    mockUserSnapshot = MockDocumentSnapshot();
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockFacebookLogin = MockFacebookLogin();
    mockFacebookLoginResult = MockFacebookLoginResult();
    mockFacebookToken = MockFacebookToken();
  }

  setUp(() {
    _setUpMocks();

    dataSource = UserRemoteDataSourceImpl(
        auth: mockAuth,
        firestore: mockFirestore,
        googleSignIn: mockGoogleSignIn,
        facebookLogin: mockFacebookLogin);
  });

  void _arrangeFirestore() {
    when(mockFirestore.collection(any)).thenReturn(mockDatabaseCollection);
    when(mockDatabaseCollection.document(any))
        .thenReturn(mockEnvironmentDocument);
    when(mockEnvironmentDocument.collection(any))
        .thenReturn(mockUsersCollection);
    when(mockUsersCollection.document(any)).thenReturn(mockUserDocument);
    when(mockUserSnapshot.data).thenReturn(userJson);
  }

  void _arrangeFirestoreUserAlreadyExist() {
    int timesCalled = 0;
    when(mockUserDocument.get()).thenAnswer((_) async => mockUserSnapshot);
    _arrangeFirestore();
  }

  void _arrangeFirestoreUserDoNotExist() {
    int timesCalled = 0;
    when(mockUserDocument.get()).thenAnswer((_) async {
      if (timesCalled == 0) {
        timesCalled++;
        return null;
      } else {
        return mockUserSnapshot;
      }
    });
    _arrangeFirestore();
  }

  group('User data source', () {
    group('Anonymous sign in', () {
      test(
          'should return create a user on the database and return a sharlist user when getAnonymousUser is called',
          () async {
        // Arrange
        when(mockAuth.signInAnonymously())
            .thenAnswer((_) async => mockAuthResult);
        when(mockAuthResult.user).thenReturn(mockFirebaseUser);
        when(mockFirebaseUser.uid).thenReturn(uid);
        _arrangeFirestoreUserAlreadyExist();

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

    group('Google sign in', () {
      test(
          'should return a sharlist user when getUserUsingGoogle is called and create the user if do not exist',
          () async {
        // Arrange
        when(mockGoogleSignIn.signIn())
            .thenAnswer((_) async => mockGoogleSignInAccount);
        when(mockGoogleSignInAccount.authentication)
            .thenAnswer((_) async => mockGoogleSignInAuthentication);
        when(mockGoogleSignInAuthentication.accessToken)
            .thenReturn(accessToken);
        when(mockGoogleSignInAuthentication.idToken).thenReturn(idToken);
        when(mockAuth.signInWithCredential(any))
            .thenAnswer((_) async => mockAuthResult);
        when(mockAuthResult.user).thenReturn(mockFirebaseUser);
        when(mockFirebaseUser.uid).thenReturn(uid);
        _arrangeFirestoreUserDoNotExist();

        // Act
        final SharlistUser result = await dataSource.getUserUsingGoogle();

        // Assert
        verify(mockGoogleSignIn.signIn());
        verify(mockAuth.signInWithCredential(any));
        verify(mockUserDocument.setData(userJson));
        verify(mockUserDocument.get());
        verifyNoMoreInteractions(mockAuth);
        expect(result, expectedUser);
      });

      test('should return a sharlist user when getUserUsingGoogle is called',
          () async {
        // Arrange
        when(mockGoogleSignIn.signIn())
            .thenAnswer((_) async => mockGoogleSignInAccount);
        when(mockGoogleSignInAccount.authentication)
            .thenAnswer((_) async => mockGoogleSignInAuthentication);
        when(mockGoogleSignInAuthentication.accessToken)
            .thenReturn(accessToken);
        when(mockGoogleSignInAuthentication.idToken).thenReturn(idToken);
        when(mockAuth.signInWithCredential(any))
            .thenAnswer((_) async => mockAuthResult);
        when(mockAuthResult.user).thenReturn(mockFirebaseUser);
        when(mockFirebaseUser.uid).thenReturn(uid);
        _arrangeFirestoreUserAlreadyExist();

        // Act
        final SharlistUser result = await dataSource.getUserUsingGoogle();

        // Assert
        verify(mockGoogleSignIn.signIn());
        verify(mockAuth.signInWithCredential(any));
        verifyNever(mockUserDocument.setData(any));
        verify(mockUserDocument.get());
        verifyNoMoreInteractions(mockAuth);
        expect(result, expectedUser);
      });

      test(
          'should throw UnsuccessfulGoogleSignInException when user signIn returns null',
          () async {
        when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);
        // Arrange
        final TypeMatcher expectedException =
            TypeMatcher<UnsuccessfulGoogleSignInException>();

        // Act
        final call = dataSource.getUserUsingGoogle;

        // Assert
        expect(call(), throwsA(expectedException));
      });

      test(
          'should throw a ServerException when signInWithCredentials when wrong',
          () async {
        when(mockGoogleSignIn.signIn())
            .thenAnswer((_) async => mockGoogleSignInAccount);
        when(mockGoogleSignInAccount.authentication)
            .thenAnswer((_) async => mockGoogleSignInAuthentication);
        when(mockAuth.signInWithCredential(any)).thenThrow(Exception());
        // Arrange
        final TypeMatcher expectedException =
            TypeMatcher<FirebaseSignInException>();

        // Act
        final call = dataSource.getUserUsingGoogle;

        // Assert
        expect(call(), throwsA(expectedException));
      });
    });

    group('Facebook way', () {
      test(
          'should Should return a sharlit user when getUserUsingFacebook is called',
          () async {
        // Arrange
        when(mockFacebookLogin.logIn(any))
            .thenAnswer((_) async => mockFacebookLoginResult);
        when(mockFacebookLoginResult.accessToken).thenReturn(mockFacebookToken);
        when(mockFacebookToken.token).thenReturn(idToken);
        when(mockAuth.signInWithCredential(any))
            .thenAnswer((_) async => mockAuthResult);
        when(mockAuthResult.user).thenReturn(mockFirebaseUser);
        when(mockFirebaseUser.uid).thenReturn(uid);
        _arrangeFirestoreUserAlreadyExist();

        // Act
        final SharlistUser result = await dataSource.getUserUsingFacebook();

        // Assert
        verify(mockFacebookLogin.logIn(['email']));
        verify(mockAuth.signInWithCredential(any));
        verifyNever(mockUserDocument.setData(any));
        verify(mockUserDocument.get());
        verifyNoMoreInteractions(mockAuth);
        expect(result, expectedUser);
      });

      test(
          'should Should return a sharlit user when getUserUsingFacebook is called and create the user if do not exist',
          () async {
        // Arrange
        when(mockFacebookLogin.logIn(any))
            .thenAnswer((_) async => mockFacebookLoginResult);
        when(mockFacebookLoginResult.accessToken).thenReturn(mockFacebookToken);
        when(mockFacebookToken.token).thenReturn(idToken);
        when(mockAuth.signInWithCredential(any))
            .thenAnswer((_) async => mockAuthResult);
        when(mockAuthResult.user).thenReturn(mockFirebaseUser);
        when(mockFirebaseUser.uid).thenReturn(uid);
        _arrangeFirestoreUserDoNotExist();

        // Act
        final SharlistUser result = await dataSource.getUserUsingFacebook();

        // Assert
        verify(mockFacebookLogin.logIn(['email']));
        verify(mockAuth.signInWithCredential(any));
        verify(mockUserDocument.setData(userJson));
        verify(mockUserDocument.get());
        verifyNoMoreInteractions(mockAuth);
        expect(result, expectedUser);
      });

      test(
          'should return UnsuccessfulFacebookSignInException when FacebookLoginResult is canceled by user',
          () async {
        // Arrange
        when(mockFacebookLogin.logIn(any))
            .thenAnswer((_) async => mockFacebookLoginResult);
        when(mockFacebookLoginResult.status)
            .thenReturn(FacebookLoginStatus.cancelledByUser);
        final TypeMatcher expectedException =
            TypeMatcher<UnsuccessfulFacebookSignInException>();

        // Act
        final call = dataSource.getUserUsingFacebook;

        // Assert
        verifyZeroInteractions(mockAuth);
        expect(call(), throwsA(expectedException));
      });

      test(
          'should return UnsuccessfulFacebookSignInException when FacebookLoginResult has an error',
          () async {
        // Arrange
        when(mockFacebookLogin.logIn(any))
            .thenAnswer((_) async => mockFacebookLoginResult);
        when(mockFacebookLoginResult.status)
            .thenReturn(FacebookLoginStatus.error);
        final TypeMatcher expectedException =
            TypeMatcher<UnsuccessfulFacebookSignInException>();

        // Act
        final call = dataSource.getUserUsingFacebook;

        // Assert
        verifyZeroInteractions(mockAuth);
        expect(call(), throwsA(expectedException));
      });

      test(
          'should throw a ServerException when signInWithCredentials when wrong',
          () async {
        when(mockFacebookLogin.logIn(any))
            .thenAnswer((_) async => mockFacebookLoginResult);
        when(mockFacebookLoginResult.accessToken).thenReturn(mockFacebookToken);
        when(mockFacebookToken.token).thenReturn(idToken);
        when(mockAuth.signInWithCredential(any)).thenThrow(Exception());

        // Arrange
        final TypeMatcher expectedException =
            TypeMatcher<FirebaseSignInException>();

        // Act
        final call = dataSource.getUserUsingFacebook;

        // Assert
        expect(call(), throwsA(expectedException));
      });
    });
  });
}

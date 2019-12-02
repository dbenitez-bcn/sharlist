import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sharlist/core/constants.dart';
import 'package:sharlist/core/error/exceptions.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/data/models/sharlist_user_model.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

abstract class UserRemoteDataSource {
  Future<SharlistUser> getUserUsingGoogle();
  Future<SharlistUser> getUserUsingFacebook();
  Future<SharlistUser> getAnonymousUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final Firestore firestore;
  final GoogleSignIn googleSignIn;

  UserRemoteDataSourceImpl({
    @required this.auth,
    @required this.firestore,
    @required this.googleSignIn,
  });

  @override
  Future<SharlistUser> getAnonymousUser() async {
    final String uid = await _getAnonymousUid();
    return _createUserWith(uid);
  }

  @override
  Future<SharlistUser> getUserUsingFacebook() {
    // TODO: implement getUserUsingFacebook
    return null;
  }

  @override
  Future<SharlistUser> getUserUsingGoogle() async {
    final GoogleSignInAccount account = await _getGoogleAccount();
    final AuthCredential credential = await _getAuthCredential(account);
    final String uid = await _signInWithCredential(credential);
    return _createUserWith(uid);
  }

  Future<String> _signInWithCredential(AuthCredential credential) async {
    try {
      final AuthResult response = await auth.signInWithCredential(credential);
      return _getUid(response);
    } catch (exception) {
      throw FirebaseSignInException();
    }
  }

  String _getUid(AuthResult response) => response.user.uid;

  Future<AuthCredential> _getAuthCredential(GoogleSignInAccount account) async {
    final GoogleSignInAuthentication authentication =
        await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    return credential;
  }

  Future<GoogleSignInAccount> _getGoogleAccount() async {
    final GoogleSignInAccount account = await googleSignIn.signIn();
    if (account == null) throw UnsuccessfulGoogleSignInException();
    return account;
  }

  Future<String> _getAnonymousUid() async {
    final AuthResult response = await auth.signInAnonymously();
    return _getUid(response);
  }

  Future<SharlistUser> _createUserWith(String uid) async {
    final userJson = {
      'uid': uid,
      'role': roleToString(Role.user),
    };
    await firestore
        .collection(Constants.DATABASE_COLLECTION)
        .document(Constants.ENVIRONMENT)
        .collection(Constants.USERS_COLLECTION)
        .document(uid)
        .setData(userJson);

    return _getUserByUid(uid);
  }

  Future<SharlistUser> _getUserByUid(String uid) async {
    final document = await firestore
        .collection(Constants.DATABASE_COLLECTION)
        .document(Constants.ENVIRONMENT)
        .collection(Constants.USERS_COLLECTION)
        .document(uid)
        .get();

    return SharlistUserModel.fromJson(document.data);
  }
}

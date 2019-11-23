import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:sharlist/core/constants.dart';
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

  UserRemoteDataSourceImpl({@required this.auth, @required this.firestore});

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
  Future<SharlistUser> getUserUsingGoogle() {
    // TODO: implement getUserUsingGoogle
    return null;
  }

  Future<String> _getAnonymousUid() async {
    final AuthResult response = await auth.signInAnonymously();
    return response.user.uid;
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

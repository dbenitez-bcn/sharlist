import 'package:sharlist/domain/entities/sharlist_user.dart';

abstract class UserRemoteDataSource {
  Future <SharlistUser> getUserUsingGoogle();
  Future <SharlistUser> getUserUsingFacebook();
  Future <SharlistUser> getAnonymousUser();
}
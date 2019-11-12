import 'package:meta/meta.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

class SharlistUserModel extends SharlistUser {
  SharlistUserModel({@required String uid, @required Role role})
      : super(uid: uid, role: role);

  factory SharlistUserModel.fromJson(Map<String, dynamic> json) {
    return SharlistUserModel(
      uid: json['uid'],
      role: roleFromString(json['role'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'role': roleToString(role)
    };
  }
}

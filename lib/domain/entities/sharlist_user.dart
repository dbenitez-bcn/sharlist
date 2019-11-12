import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sharlist/data/enums/role.dart';

class SharlistUser extends Equatable {
  final String uid;
  final Role role;

  SharlistUser({@required this.uid, @required this.role});

  @override
  // TODO: implement props
  List<Object> get props => [uid, role];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_default.g.dart';

@JsonSerializable()
class MemberDefault extends Equatable {
  const MemberDefault({
    required this.id,
    required this.firebaseUid,
    required this.accountUniqueKey,
  });

  final int id;
  final String firebaseUid;
  final String accountUniqueKey;

  static const empty = MemberDefault(
    id: -1,
    firebaseUid: '',
    accountUniqueKey: '',
  );

  static const anonymous = MemberDefault(
    id: -2,
    firebaseUid: '',
    accountUniqueKey: '',
  );

  bool get isAnonymous => this == MemberDefault.anonymous;

  bool get isNotAnonymous => this != MemberDefault.anonymous;

  bool get isEmpty => this == MemberDefault.empty;

  bool get isNotEmpty => this != MemberDefault.empty;

  factory MemberDefault.fromJson(Map<String, dynamic> json) =>
      _$MemberDefaultFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDefaultToJson(this);

  @override
  List<Object?> get props => [id, firebaseUid, accountUniqueKey];

  @override
  String toString() =>
      'Member { id: $id, firebaseUid: $firebaseUid, accountUniqueKey: $accountUniqueKey }';
}

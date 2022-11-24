// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_default.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDefault _$MemberDefaultFromJson(Map<String, dynamic> json) =>
    MemberDefault(
      id: json['id'] as int,
      firebaseUid: json['firebaseUid'] as String,
      accountUniqueKey: json['accountUniqueKey'] as String,
    );

Map<String, dynamic> _$MemberDefaultToJson(MemberDefault instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firebaseUid': instance.firebaseUid,
      'accountUniqueKey': instance.accountUniqueKey,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetToken$Query$RTCToken _$GetToken$Query$RTCTokenFromJson(
    Map<String, dynamic> json) {
  return GetToken$Query$RTCToken()..token = json['token'] as String;
}

Map<String, dynamic> _$GetToken$Query$RTCTokenToJson(
        GetToken$Query$RTCToken instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

GetToken$Query _$GetToken$QueryFromJson(Map<String, dynamic> json) {
  return GetToken$Query()
    ..rtcToken = GetToken$Query$RTCToken.fromJson(
        json['rtcToken'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetToken$QueryToJson(GetToken$Query instance) =>
    <String, dynamic>{
      'rtcToken': instance.rtcToken.toJson(),
    };

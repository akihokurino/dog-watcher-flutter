// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraToken$Query$AgoraToken _$AgoraToken$Query$AgoraTokenFromJson(
    Map<String, dynamic> json) {
  return AgoraToken$Query$AgoraToken()..token = json['token'] as String;
}

Map<String, dynamic> _$AgoraToken$Query$AgoraTokenToJson(
        AgoraToken$Query$AgoraToken instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

AgoraToken$Query _$AgoraToken$QueryFromJson(Map<String, dynamic> json) {
  return AgoraToken$Query()
    ..agoraToken = AgoraToken$Query$AgoraToken.fromJson(
        json['agoraToken'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AgoraToken$QueryToJson(AgoraToken$Query instance) =>
    <String, dynamic>{
      'agoraToken': instance.agoraToken.toJson(),
    };

AgoraTokenArguments _$AgoraTokenArgumentsFromJson(Map<String, dynamic> json) {
  return AgoraTokenArguments(
    channelName: json['channelName'] as String,
  );
}

Map<String, dynamic> _$AgoraTokenArgumentsToJson(
        AgoraTokenArguments instance) =>
    <String, dynamic>{
      'channelName': instance.channelName,
    };

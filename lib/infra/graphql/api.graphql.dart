// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class GetToken$Query$RTCToken extends JsonSerializable with EquatableMixin {
  GetToken$Query$RTCToken();

  factory GetToken$Query$RTCToken.fromJson(Map<String, dynamic> json) =>
      _$GetToken$Query$RTCTokenFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$GetToken$Query$RTCTokenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetToken$Query extends JsonSerializable with EquatableMixin {
  GetToken$Query();

  factory GetToken$Query.fromJson(Map<String, dynamic> json) =>
      _$GetToken$QueryFromJson(json);

  late GetToken$Query$RTCToken rtcToken;

  @override
  List<Object?> get props => [rtcToken];
  @override
  Map<String, dynamic> toJson() => _$GetToken$QueryToJson(this);
}

final GET_TOKEN_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetToken'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'rtcToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class GetTokenQuery extends GraphQLQuery<GetToken$Query, JsonSerializable> {
  GetTokenQuery();

  @override
  final DocumentNode document = GET_TOKEN_QUERY_DOCUMENT;

  @override
  final String operationName = 'GetToken';

  @override
  List<Object?> get props => [document, operationName];
  @override
  GetToken$Query parse(Map<String, dynamic> json) =>
      GetToken$Query.fromJson(json);
}

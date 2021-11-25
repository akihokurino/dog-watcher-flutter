// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class AgoraToken$Query$AgoraToken extends JsonSerializable with EquatableMixin {
  AgoraToken$Query$AgoraToken();

  factory AgoraToken$Query$AgoraToken.fromJson(Map<String, dynamic> json) =>
      _$AgoraToken$Query$AgoraTokenFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$AgoraToken$Query$AgoraTokenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgoraToken$Query extends JsonSerializable with EquatableMixin {
  AgoraToken$Query();

  factory AgoraToken$Query.fromJson(Map<String, dynamic> json) =>
      _$AgoraToken$QueryFromJson(json);

  late AgoraToken$Query$AgoraToken agoraToken;

  @override
  List<Object?> get props => [agoraToken];
  @override
  Map<String, dynamic> toJson() => _$AgoraToken$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgoraTokenArguments extends JsonSerializable with EquatableMixin {
  AgoraTokenArguments({required this.channelName});

  @override
  factory AgoraTokenArguments.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenArgumentsFromJson(json);

  late String channelName;

  @override
  List<Object?> get props => [channelName];
  @override
  Map<String, dynamic> toJson() => _$AgoraTokenArgumentsToJson(this);
}

final AGORA_TOKEN_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AgoraToken'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'channelName')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'agoraToken'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'channelName'),
                  value: VariableNode(name: NameNode(value: 'channelName')))
            ],
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

class AgoraTokenQuery
    extends GraphQLQuery<AgoraToken$Query, AgoraTokenArguments> {
  AgoraTokenQuery({required this.variables});

  @override
  final DocumentNode document = AGORA_TOKEN_QUERY_DOCUMENT;

  @override
  final String operationName = 'AgoraToken';

  @override
  final AgoraTokenArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  AgoraToken$Query parse(Map<String, dynamic> json) =>
      AgoraToken$Query.fromJson(json);
}

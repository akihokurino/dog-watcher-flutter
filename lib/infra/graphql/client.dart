import 'package:dog_watcher/model/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';

class GQClient {
  static final GQClient _singleton = GQClient._internal();

  factory GQClient() {
    return _singleton;
  }

  GQClient._internal();

  late final String _baseUrl;

  setup(String baseUrl) {
    _baseUrl = baseUrl;
  }

  Future<Map<String, dynamic>> query(QueryOptions options) async {
    final token = await _accessToken();
    final headers = <String, String>{};
    headers["authorization"] = "bearer $token";

    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(_baseUrl, defaultHeaders: headers),
    );

    final result = await client.query(options);

    if (result.hasException) {
      String message = "エラーが発生しました";
      if (result.exception!.graphqlErrors.isNotEmpty) {
        message = result.exception!.graphqlErrors.first.message;
      }

      throw AppError(message);
    }

    final data = result.data;
    if (data == null) {
      throw AppError("エラーが発生しました");
    }

    return data;
  }

  Future<Map<String, dynamic>> mutation(MutationOptions options) async {
    final token = await _accessToken();
    final headers = <String, String>{};
    headers["authorization"] = "bearer $token";

    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(_baseUrl, defaultHeaders: headers),
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      String message = "エラーが発生しました";
      if (result.exception!.graphqlErrors.isNotEmpty) {
        message = result.exception!.graphqlErrors.first.message;
      }

      throw AppError(message);
    }

    final data = result.data;
    if (data == null) {
      throw AppError("エラーが発生しました");
    }

    return data;
  }

  Future<String> _accessToken() async {
    try {
      final fireUser = FirebaseAuth.instance.currentUser;
      if (fireUser == null) {
        return "";
      }

      final token = await fireUser.getIdToken(true);

      return token;
    } catch (_) {
      return Future.value("");
    }
  }
}

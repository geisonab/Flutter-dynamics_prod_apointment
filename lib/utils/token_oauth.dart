import 'package:dynamics_prod_apointment/models/token_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenOAuth {
  static TokenOAuth? _instance;

  TokenOAuth._();

  static TokenOAuth get instance => _instance ??= TokenOAuth._();

  Future<TokenModel> getToken() async {
    return _send();
  }

  Future<TokenModel> _send() async {
    String tenant = "e45f7a95-21b8-4898-ac8d-cdcc2b3d3649";
    String clientId = "6376293b-3001-4af6-9ceb-104564cb58cf";
    String clientSecret = "MyR8Q~9-wb4J-_HLdAZBjeZbj6ocl4Zjpr8VjbGG";
    String environmetUri =
        "https://zanini-dev-gsn2c5fc7c06dcd9bcddevaos.axcloud.dynamics.com";

    var response = await http.post(
        Uri.parse(
            "https://login.microsoftonline.com/$tenant/oauth2/v2.0/token"),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'client_credentials',
          'Scope': '$environmetUri/.default',
        });

    TokenModel data = TokenModel.fromJson(jsonDecode(response.body));
    return data;
  }
}

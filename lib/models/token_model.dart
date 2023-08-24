class TokenModel {
  String token = "";
  int expiration = 0;

  TokenModel(this.token, this.expiration);

  TokenModel.fromJson(Map<String, dynamic> json)
      : token = json['access_token'],
        expiration = json['expires_in'];

  Map<String, dynamic> toJson() => {
        'access_token': token,
        'expires_in': expiration,
      };
}

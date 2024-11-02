
class SessionToken {
  final int expiresAt ;
  final String sessionToken;

  SessionToken({this.expiresAt = 0, this.sessionToken = ""});

  SessionToken fromJson(Map<String, dynamic> json){
    return SessionToken(expiresAt: json["expires_at"], sessionToken: json["session"]);
  }
}

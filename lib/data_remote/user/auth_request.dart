class AuthRequest {
  final String token;
  final String id;
  final String idToken;
  final String? email;

  AuthRequest(this.token, this.id, this.idToken, this.email);
}
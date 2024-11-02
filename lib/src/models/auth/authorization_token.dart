class AuthorizationToken {
  final String accessToken;
  final String type = 'Bearer';

  AuthorizationToken({required this.accessToken});

  @override
  String toString() {
    return '$type $accessToken';
  }
}

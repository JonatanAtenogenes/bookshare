class CsrfToken {
  final String csrfToken;

  // Constructor
  CsrfToken({
    required this.csrfToken,
  });

  // Factory method for JSON parsing
  factory CsrfToken.fromJson(Map<String, dynamic> json) {
    return CsrfToken(
      csrfToken: json['csrf_token'],
    );
  }
}

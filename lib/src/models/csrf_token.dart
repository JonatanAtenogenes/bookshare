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

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'X-CSRF-TOKEN': csrfToken,
    };
  }
}

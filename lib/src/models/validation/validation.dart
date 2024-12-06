/// The `Validation` class represents the result of a validation process.
/// It contains information about whether the validation was successful,
/// an identifier for the validation, and an optional message detailing
/// the validation outcome.
class Validation {
  /// Indicates whether the validation was successful.
  final bool isValid;

  /// A unique identifier for the validation.
  final int id;

  /// An optional message that provides additional information about
  /// the validation result.
  final String? message;

  /// Creates a `Validation` instance with the specified validation status,
  /// identifier, and optional message.
  ///
  /// - `isValid`: A boolean that indicates if the validation was successful.
  /// - `id`: An integer identifier for the validation.
  /// - `message`: An optional message describing the validation outcome.
  Validation({
    required this.isValid,
    required this.id,
    this.message,
  });

  /// Returns a map representation of the `Validation` instance.
  ///
  /// The returned map includes:
  /// - `isValid`: The validation status as a boolean.
  /// - `id`: The validation identifier as an integer.
  /// - `message`: The validation message, which can be null if not provided.
  Map<String, dynamic> get validation {
    return {
      "isValid": isValid,
      "id": id,
      "message": message,
    };
  }
}

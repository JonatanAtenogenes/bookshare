/// A class representing a locality with an identifier, postal code, name, city, and state.
///
/// The [Locality] class encapsulates information about a location, including
/// a unique identifier, postal code, locality name, city, and state.
class Locality {
  /// Unique identifier for the locality.
  final String id;

  /// Postal code associated with the locality.
  final int postalCode;

  /// Name of the locality.
  final String locality;

  /// City associated with the locality.
  final String city;

  /// State associated with the locality.
  final String state;

  /// Creates an instance of [Locality].
  Locality({
    required this.id,
    required this.postalCode,
    required this.locality,
    required this.city,
    required this.state,
  });

  /// Creates an empty instance of [Locality].
  ///
  /// This constructor initializes the locality with default values:
  /// - `id` as an empty string
  /// - `postalCode` as 0
  /// - `locality`, `city`, and `state` as empty strings
  Locality.empty()
      : id = '',
        postalCode = 0,
        locality = '',
        city = '',
        state = '';

  /// Converts a [Locality] instance to a JSON-compatible map.
  ///
  /// Returns a map with keys `id`, `postalCode`, `locality`, `city`, and `state`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postalCode': postalCode,
      'locality': locality,
      'city': city,
      'state': state,
    };
  }

  /// Creates a [Locality] instance from a JSON map.
  ///
  /// The JSON map should contain the keys `id`, `d_codigo`, `d_asenta`, `D_mnpio`, and `d_estado`.
  ///
  /// Throws a [FormatException] if any required key is missing.
  factory Locality.fromJson(Map<String, dynamic> json) {
    return Locality(
      id: json['id'] as String,
      postalCode: json['d_codigo'] as int,
      locality: json['d_asenta'] as String,
      city: json['D_mnpio'] as String,
      state: json['d_estado'] as String,
    );
  }

  /// Creates a list of [Locality] instances from a list of JSON objects.
  ///
  /// This method expects a list of JSON maps, each containing the keys `id`, `d_codigo`, `d_asenta`,
  /// `D_mnpio`, and `d_estado`.
  static List<Locality> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Locality.fromJson(json)).toList();
  }
}

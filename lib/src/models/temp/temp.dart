class BookUser {
  late final String name;
  late final String bookName;
  late final String author;
  late final String uri;
  late final int value;

  BookUser({
    required this.name,
    required this.bookName,
    required this.uri,
    required this.value,
    required this.author,
  });

  Map<String, dynamic> get getBookUser {
    return {
      'name': name,
      'bookName': bookName,
      'uri': uri,
      'author': author,
      'value': value,
    };
  }
}

class Library {
  late final String name;
  late final String address;
  late final String state;
  late final String city;

  Library({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
  });

  Map<String, dynamic> get getLibrary {
    return {
      'name': name,
      'address': address,
      'city': city,
      'state': state,
    };
  }
}

class User {
  User(
      {this.id,
      required this.name,
      required this.dateOfBirth,
      required this.address,
      required this.cep});

  String? id;
  String name;
  String dateOfBirth;
  String address;
  String cep;

  factory User.fromJson(Map parsedJson) {
    String returnedDateOfBirth = parsedJson['dateOfBirth'];
    String convertedDateOfBirth =
        '${returnedDateOfBirth.substring(8, 10)}/${returnedDateOfBirth.substring(5, 7)}/${returnedDateOfBirth.substring(0, 4)}';
    String returnedCep = parsedJson['cep'];
    String convertedCep =
        '${returnedCep.substring(0, 2)}.${returnedCep.substring(2, 5)}-${returnedCep.substring(5, 8)}';
    return User(
        id: parsedJson['id'],
        name: parsedJson['name'],
        dateOfBirth: convertedDateOfBirth,
        address: parsedJson['address'],
        cep: convertedCep);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'cep': cep,
    };
  }
}

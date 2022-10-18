// ignore: file_names
class UserModel {
  String? identification;
  String? name;
  String? lastName;
  String? ip;
  String? plan;
  String? phoneNumber;

  UserModel({
    this.identification,
    this.name,
    this.lastName,
    this.ip,
    this.plan,
    this.phoneNumber,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      identification: map['identification'],
      name: map['name'],
      lastName: map['lastName'],
      ip: map['ip'],
      plan: map['plan'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'identification': identification,
      'name': name,
      'lastName': lastName,
      'ip': ip,
      'plan': plan,
      'phoneNumber': phoneNumber,
    };
  }
}

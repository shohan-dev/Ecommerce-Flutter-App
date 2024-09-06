class UserModel {
  final String email;
  final String username;
  final String phone;
  final String firstName;
  final String lastName;
  final String imgUrl;

  // Full name is computed based on firstName and lastName
  String get fullName => "$firstName $lastName";

  UserModel({
    required this.email,
    required this.username,
    required this.phone,
    required this.firstName,
    required this.lastName,
    this.imgUrl = "",
  });

  static Future<UserModel> fromSnapshot(Map<String, dynamic> map) {
    return Future.value(UserModel(
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      imgUrl: map['imgUrl'],
    ));
  }
}

// Convert the user data to JSON and save it to Firestore
extension UserModelX on UserModel {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'imgUrl': imgUrl,
    };
  }
}

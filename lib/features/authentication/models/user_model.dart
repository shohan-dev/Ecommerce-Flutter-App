class UserModel {
  final String email;
  final String username;
  final String phone;
  final String firstName;
  final String lastName;
  final String imgUrl;
  final String uid;
  final String gender;
  // ignore: non_constant_identifier_names
  final String date_of_birth;
  // gender and date of birth
  // add Wishlist map
  final List<String> Wishlist;

  // Full name is computed based on firstName and lastName
  String get fullName => "$firstName $lastName";

  UserModel({
    required this.email,
    required this.username,
    required this.phone,
    required this.firstName,
    required this.lastName,
    this.imgUrl = "",
    required this.uid,
    required this.gender,
    // ignore: non_constant_identifier_names
    required this.date_of_birth,
    this.Wishlist = const [],
  });

  static Future<UserModel> fromSnapshot(Map<String, dynamic> map) {
    return Future.value(UserModel(
      uid: map['uid'],
      gender: map["gender"],
      date_of_birth: map["date_of_birth"],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      imgUrl: map['imgUrl'],
      Wishlist: List<String>.from(map['Wishlist'] ?? []),
    ));
  }

  static empty() {
    return UserModel(
      uid: '',
      email: '',
      username: '',
      phone: '',
      firstName: '',
      lastName: '',
      imgUrl: '',
      gender: '',
      date_of_birth: '',
      Wishlist: [],
    );
  }

  // Factory constructor to create an instance from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      gender: map['gender'] ?? '',
      date_of_birth: map['date_of_birth'] ?? '',
      Wishlist: List<String>.from(map['Wishlist'] ?? []),
    );
  }
}

// Convert the user data to JSON and save it to Firestore
extension UserModelX on UserModel {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'imgUrl': imgUrl,
      'gender': gender,
      'date_of_birth': date_of_birth,
      'Wishlist': Wishlist,
    };
  }
}

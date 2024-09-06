import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/features/authentication/models/user_model.dart';

class UserControllers extends GetxController {
  static UserControllers instance = Get.put(UserControllers());

  // Save user record
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        // Extracting details from userCredential
        final firstName =
            userCredential.additionalUserInfo?.profile?['given_name'];
        final lastName =
            userCredential.additionalUserInfo?.profile?['family_name'];
        final imgUrl = userCredential.additionalUserInfo?.profile?['picture'];
        final email = userCredential.user?.email;

        // Ensure email is not null
        if (email == null) {
          throw Exception('User email is null.');
        }

        // Generate username and phone number
        final username = await generateUsername(email);
        final phoneNumber = await generatePhoneNo();

        // Create a new user model
        final user = UserModel(
          email: email,
          username: username,
          phone: phoneNumber,
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          imgUrl: imgUrl ?? '',
        );

        // Save the user record to Firestore
        await UserRepository.instance.saveUserRecord(user);
      } else {
        throw Exception('No user is currently signed in.');
      }
    } catch (e) {
      // Display a warning if saving the record fails
      TLoaders.warningSnackBar(title: "Data not saved", message: e.toString());
    }
  }
}

// Generate a username by appending a random number to the base email prefix
Future<String> generateUsername(String email) async {
  String baseUsername = email.split('@')[0];
  Random random = Random();
  baseUsername += random.nextInt(900).toString();
  return baseUsername;
}

// Generate a valid 11-digit phone number starting with '01'
Future<String> generatePhoneNo() async {
  Random random = Random();
  String phoneNumber =
      '01${random.nextInt(900000000).toString().padLeft(9, '0')}';
  return phoneNumber;
}

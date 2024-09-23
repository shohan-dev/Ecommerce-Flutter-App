import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/features/authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.put(UserController());

  Rx<UserModel?> user = Rx<UserModel?>(null); // Store UserModel
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Fetch user data on initialization
  }

  void fetchUserData() {
    isLoading.value = true; // Set loading to true
    UserRepository.instance.fetchUserDetailsStream().listen((userData) {
      user.value = userData; // Update user data
      isLoading.value = false; // Stop loading
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching user details: $error');
      }
      isLoading.value = false; // Stop loading on error
      user.value = null; // Handle error case
    });
  }

  // Save user record
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        // Extracting details from userCredential
        final profile = userCredential.additionalUserInfo?.profile ?? {};
        final firstName = profile['given_name'] ?? '';
        final lastName = profile['family_name'] ?? '';
        final imgUrl = profile['picture'] ?? '';
        final email = userCredential.user?.email;

        // Ensure email is not null
        if (email == null) {
          throw Exception('User email is null.');
        }

        // Generate username and phone number
        final username = await generateUsername(email);

        // Create a new user model
        final user = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          username: username,
          phone: 'Phone number not provided',
          firstName: firstName,
          lastName: lastName,
          imgUrl: imgUrl,
          gender: 'Add gender',
          date_of_birth: 'Add date of birth',
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

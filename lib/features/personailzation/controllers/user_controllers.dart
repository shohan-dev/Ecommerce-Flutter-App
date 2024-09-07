import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/features/authentication/models/user_model.dart';

class UserControllers extends GetxController {
  static UserControllers instance = Get.put(UserControllers());

  Rx<UserModel?> user = Rx<UserModel?>(UserModel.empty());
  final RxBool isLoading = false.obs;

  //oninit
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //fetch user record from firestore
  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      final user = await UserRepository.instance.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

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

        // Create a new user model
        final user = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          username: username,
          phone: 'Phone number not provided',
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          imgUrl: imgUrl ?? '',
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

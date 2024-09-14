import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/features/authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.put(UserController());

  // Rx<UserModel?> user = Rx<UserModel?>(UserModel.empty());
  // Rx<Map<String, dynamic>?> user = Rx<Map<String, dynamic>?>(null);
  Rx<UserModel?> user = Rx<UserModel?>(null); // Update type to hold UserModel

  final RxBool isLoading = false.obs;

  // Called when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    print(
        "Fetch Data First suere maybe.................................................................... Start");

    // fetchUserRecord(); // old ways of fetching data
    fetchUserData(); // Realtime new ways of fetching data
    print(
        "End Fetch Data suere maybe.................................................................... End");
  }

  void fetchUserData() {
    
    UserRepository.instance.fetchUserDetailsStream().listen((userData) {
      user.value = userData; // Store UserModel in observable
    }, onError: (error) {
      print('Error fetching user details: $error');
      user.value = null; // Set to null on error
    });
  }

  // // Fetch user record from Firestore
  // Future<void> fetchUserRecord() async {
  //   try {
  //     isLoading.value = true; // Set loading state to true
  //     final fetchedUser = await UserRepository.instance.fetchUserDetails();
  //     user.value = fetchedUser; // Update user using .value
  //     user.refresh(); // Refresh the user state
  //   } catch (e) {
  //     user.value = UserModel.empty(); // Reset user model on error
  //     TLoaders.warningSnackBar(
  //         title: "Fetch Error",
  //         message: "Failed to fetch user details. Error: ${e.toString()}");
  //   } finally {
  //     isLoading.value = false; // Reset loading state
  //   }
  // }

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

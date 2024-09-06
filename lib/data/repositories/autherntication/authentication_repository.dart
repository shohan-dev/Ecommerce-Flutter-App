import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/features/authentication/screen/onboarding/onboarding.dart';
import 'package:smartshop/features/authentication/screen/signup/verify_email.dart';
import 'package:smartshop/navigation_menu.dart';
import 'package:smartshop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';
import 'package:smartshop/utils/exceptions/format_exceptions.dart';
import 'package:smartshop/utils/exceptions/platform_exceptions.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final GetStorage deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
    super.onReady();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenuPage());
        return;
      } else {
        String email = user.email!;
        Get.offAll(() => VerifyEmailScreen(emailGet: email));
        return;
      }
    }

    bool isFirstTime = deviceStorage.read('isFirstTime') ?? true;

    if (isFirstTime) {
      deviceStorage.write('isFirstTime', false);
      Get.offAll(() => const OnBoardingScreen());
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to create a user with email and password
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      // Handle FirebaseException
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      // Handle FormatException
      throw const TFormatException();
    } on PlatformException catch (e) {
      // Handle PlatformException
      throw TPlatformException(e.code);
    } catch (e) {
      // Handle any other exceptions
      throw 'Something went wrong. Please try again.';
    }
  }

  // email verification
  Future<void> sendEmailVerification() async {
    try {
      // Ensure the current user is authenticated and available
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'No authenticated user found. Please log in first.';
      }

      // Attempt to send email verification
      await user.sendEmailVerification();
    }
    //  on FirebaseAuthException catch (e) {
    //   // Handle FirebaseAuthException
    //   throw TFirebaseAuthException(e.code);
    // } on FirebaseException catch (e) {
    //   // Handle FirebaseException
    //   throw TFirebaseException(e.code);
    // } on PlatformException catch (e) {
    //   // Handle PlatformException
    //   throw TPlatformException(e.code);
    // }
    catch (e) {
      // Handle any other exceptions how to skip this
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // logout
  Future<void> logout() async {
    try {
      // Attempt to sign out
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      // throw TFirebaseAuthException(e.code).message;
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      // Handle FirebaseException
      throw TFirebaseException(e.code);
    } on PlatformException catch (e) {
      // Handle PlatformException
      throw TPlatformException(e.code);
    } catch (e) {
      // Handle any other exceptions
      throw 'Something went wrong. Please try again.';
    }
  }

  void signOut() {
    _auth.signOut();
    Get.offAll(() => const LoginPage());
  }

  // login
  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      // Handle FirebaseException
      throw TFirebaseException(e.code);
    } on PlatformException catch (e) {
      // Handle PlatformException
      throw TPlatformException(e.code);
    } catch (e) {
      // Handle any other exceptions
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // If the user cancels the sign-in process
        TFullScreenLoader.closeLoadingDialog();
        TLoaders.errorSnackBar(
          title: "Sign-In Cancelled",
          message: "User cancelled the sign-in process.",
        );
        return null; // Return null to indicate the sign-in was not completed
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the obtained access and ID tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the obtained credential
      return await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      // Handle FirebaseException
      throw TFirebaseException(e.code);
    } on PlatformException catch (e) {
      // Handle PlatformException
      throw TPlatformException(e.code);
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<void> checkIfUserExist(String trim) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user
    User? user = auth.currentUser;

    if (user != null) {


      // Check if the user signed in with email or Google
      final List<UserInfo> userInfo = user.providerData;

      bool isGoogleSignIn = false;
      bool isEmailSignIn = false;
      

      for (UserInfo info in userInfo) {
        if (info.providerId == 'google.com') {
          isGoogleSignIn = true;
          break;
        } else if (info.providerId == 'password') {
          isEmailSignIn = true;
        }
      }

      if (isGoogleSignIn) {
        print('User signed in with Google');
      } else if (isEmailSignIn) {
        print('User signed in with Email');
      } else {
        print('User signed in with another method');
      }
    } else {
      print('No user is signed in.');
    }
  }
}

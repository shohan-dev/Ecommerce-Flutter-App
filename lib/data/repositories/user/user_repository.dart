import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/authentication/models/user_model.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';
import 'package:smartshop/utils/exceptions/format_exceptions.dart';
import 'package:smartshop/utils/exceptions/platform_exceptions.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.put(UserRepository());

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  // Realtime Fetch user details from Firestore as a stream
  Stream<UserModel> fetchUserDetailsStream() {
    return _db.collection("Users").doc(user!.uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!); // Convert Map to UserModel
      } else {
        throw 'User not found';
      }
    });
  }

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.uid).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =
          await _db.collection("Users").doc(user!.uid).get();

      if (documentSnapshot.exists) {
        // Assuming UserModel has a fromMap factory constructor
        return UserModel.fromSnapshot(documentSnapshot.data()!);
      } else {
        throw 'User not found';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateUserDetailsName(String firstName, String lastName) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await _db
          .collection("Users")
          .doc(user?.uid)
          .update({"firstName": firstName, "lastName": lastName});
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> singleUpdateUserDetails(String fieldName, String value) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await _db.collection("Users").doc(user?.uid).update({fieldName: value});
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      await _db.collection("Users").doc(user!.uid).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<bool> imageUploadUser(File? file) async {
    if (file == null) {
      throw 'No file provided.';
    }

    try {
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('UserProfile')
          .child('${user!.uid}.jpg');

      // Upload the file
      await ref.putFile(file);

      // Get the download URL
      final String url = await ref.getDownloadURL();

      // Update the user's document with the new image URL
      await _db.collection("Users").doc(user!.uid).update({"imgUrl": url});

      // Return true if everything is successful
      return true;
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      if (kDebugMode) {
        print('FirebaseException: ${e.message}');
      } // Logging for debugging
      return false;
    } on FormatException catch (_) {
      // Handle format exceptions
      if (kDebugMode) {
        print('FormatException: Invalid format');
      } // Logging for debugging
      return false;
    } on PlatformException catch (e) {
      // Handle platform exceptions
      if (kDebugMode) {
        print('PlatformException: ${e.message}');
      } // Logging for debugging
      return false;
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('Unknown exception: ${e.toString()}');
      } // Logging for debugging
      return false;
    }
  }
}

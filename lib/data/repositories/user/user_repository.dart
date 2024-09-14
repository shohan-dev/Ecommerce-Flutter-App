import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> updateUserDetails(String firstName, String lastName) async {
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
}

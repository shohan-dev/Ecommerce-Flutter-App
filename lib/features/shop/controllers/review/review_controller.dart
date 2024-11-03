import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WriteReviewController extends GetxController {
  static WriteReviewController get instance => Get.find();
  var rating = 1.0.obs; // Observable for rating
  var reviewText = ''.obs; // Observable for review text

  var fullName = ''.obs; // Observable for full name
  var email = ''.obs; // Observable for email
  var reviewList = <Map<String, dynamic>>[].obs;

  void submitReview(int docid) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User is not logged in',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Fetch user info
    getUserInfo(user.uid).then((_) {
      if (reviewText.value.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('Shop_Products')
            .doc(docid
                .toString()) // No need to convert to string, already a string
            .update({
          'reviews': FieldValue.arrayUnion([
            {
              'reviewerName': fullName.value,
              'reviewerEmail': email.value,
              'rating': rating.value.toDouble(),
              'comment': reviewText.value,
              'date': DateTime.now().toString(),
            }
          ]),
        }).then((_) {
          Get.snackbar('Success', 'Review submitted successfully',
              snackPosition: SnackPosition.BOTTOM);
        }).catchError((error) {
          Get.snackbar('Error', 'Failed to submit review: $error',
              snackPosition: SnackPosition.BOTTOM);
        });
      } else {
        Get.snackbar('Error', 'Please enter a review',
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to retrieve user info: $error',
          snackPosition: SnackPosition.BOTTOM);
    });

    Get.back();
  }

  Future<void> getUserInfo(String uid) async {
    try {
      final value =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (value.exists) {
        final data = value.data();
        fullName.value = data?['fullName'] ?? ''; // Assign to observable
        email.value = data?['email'] ?? ''; // Assign to observable
      } else {
        print("User document does not exist.");
      }
    } catch (error) {
      print("Error retrieving user info: $error");
    }
  }

  Future<List<Map<String, dynamic>>> fetch_rating_review(
      String docid_index) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User is not logged in',
          snackPosition: SnackPosition.BOTTOM);
      return []; // Return an empty list if the user is not logged in
    }

    try {
      final value = await FirebaseFirestore.instance
          .collection('Shop_Products')
          .doc(docid_index)
          .get();

      final data = value.data();
      if (data != null) {
        final reviews = data['reviews'];
        if (reviews is List) {
          // Ensure reviews is a List
          reviewList.value = List<Map<String, dynamic>>.from(reviews);
          // print("Review list: $reviewList");
          return reviewList.value; // Return the review list
        } else {
          Get.snackbar('Info', 'No reviews available',
              snackPosition: SnackPosition.BOTTOM);
          return []; // Return an empty list if no reviews
        }
      } else {
        Get.snackbar('Error', 'No data found for this product',
            snackPosition: SnackPosition.BOTTOM);
        return []; // Return an empty list if no data
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch reviews: $error',
          snackPosition: SnackPosition.BOTTOM);
      return []; // Return an empty list on error
    }
  }
}

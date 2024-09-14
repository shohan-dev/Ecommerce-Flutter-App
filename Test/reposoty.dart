import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.put(UserRepository());

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Stream<Map<String, dynamic>> fetchUserDetailsStream() {
    return _db.collection("Users").doc(user!.uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        throw 'User not found';
      }
    });
  }
}

class UserController extends GetxController {
  static UserController get instance => Get.put(UserController());

  Rx<Map<String, dynamic>?> user = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    UserRepository.instance.fetchUserDetailsStream().listen((userData) {
      user.value = userData;
    }, onError: (error) {
      print('Error fetching user details: $error');
      user.value = null;
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = UserController.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        final user = userController.user.value;

        if (user == null) {
          return Center(child: Text('Loading...'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user['firstName']} ${user['lastName']}',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Email: ${user['email']}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Phone: ${user['phone']}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Phone: ${user['uid']}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Phone: ${user['fullName']}',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        );
      }),
    );
  }
}

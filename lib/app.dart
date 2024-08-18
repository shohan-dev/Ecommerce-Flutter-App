import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key); // Constructor corrected

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Changed Scaffold to MaterialApp for full app setup
      title: 'Ecomarce App', // Replace with your app's title
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme, // Replace with your light theme
      darkTheme: TAppTheme.darkTheme, // Replace with your dark theme
      debugShowCheckedModeBanner: false, // Set to false for production
      // initialBinding: GeneralBindings(), // Uncomment if using GetX bindings
      // home: const Scaffold(body: OnBoardingScreen()),
      home: const Scaffold(),
    );
  }
}

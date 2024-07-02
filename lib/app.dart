import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key); // Constructor corrected

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Changed Scaffold to MaterialApp for full app setup
      title: 'Your App Title', // Replace with your app's title
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme, // Replace with your light theme
      darkTheme: TAppTheme.darkTheme, // Replace with your dark theme
      debugShowCheckedModeBanner: true, // Set to false for production
      // initialBinding: GeneralBindings(), // Uncomment if using GetX bindings
      home: Scaffold(
        appBar: AppBar(
          title: Text(TTexts.appName), // Example app bar with title
        ),
        body: Center(
          child: Text(
            TTexts.onBoardingSubTitle1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

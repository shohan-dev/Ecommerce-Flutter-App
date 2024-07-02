import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key); // Constructor corrected

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Changed Scaffold to MaterialApp for full app setup
      title: 'Your App Title', // Replace with your app's title
      themeMode: ThemeMode.system,
      theme: ThemeData.light(), // Replace with your light theme
      darkTheme: ThemeData.dark(), // Replace with your dark theme
      debugShowCheckedModeBanner: true, // Set to false for production
      // initialBinding: GeneralBindings(), // Uncomment if using GetX bindings
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your App Title'), // Example app bar with title
        ),
        body: Center(
          child: Text(
            'Awesome! 🎊 Project Structure is set up and running. \n Happy Coding! 🎊',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

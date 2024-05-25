import 'package:e_commerce_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Widget/navigation_menu.dart';
import 'screens/vendor_profile_screen.dart'; // Import your vendor profile screen file

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This function initializes Firebase and returns a Future
  Future<FirebaseApp> initializeFirebase() async {
    final FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;
    final FirebaseApp app = await Firebase.initializeApp(
      options: options,
    );
    return app;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize Firebase asynchronously
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for Firebase initialization, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error during initialization, display an error message
          return Center(child: Text('Error initializing Firebase'));
        } else {
          // Once Firebase is initialized, return MaterialApp with Navigator
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: NavigationMenu(), // Home screen with navigation menu
            routes: {
              '/vendorProfile': (context) => VendorProfileScreen(), // Route for vendor profile screen
            },
          );
        }
      },
    );
  }
}

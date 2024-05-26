import 'package:e_commerce_mobile/providers/productProvider.dart';
import 'package:e_commerce_mobile/screens/AddProductScreen.dart';
import 'package:e_commerce_mobile/screens/AllProductsScreen.dart';
import 'package:e_commerce_mobile/screens/CompleteProfileScreen.dart';
import 'package:e_commerce_mobile/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widget/navigation_menu.dart';
import 'providers/AuthProvider.dart';

Future<void> main() async {
//    WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider())
      ],
      
      child: MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationMenu(),
       initialRoute: '/',
          routes: {
            '/addProduct': (ctx) => const AddProductScreen(),
            '/all-product': (ctx) => const AllProductsScreen(),
            ProfileScreen.routeName: (ctx) => const ProfileScreen(),
            CompleteProfileScreen.routeName: (ctx) => CompleteProfileScreen(authProvider: Provider.of<AuthProvider>(ctx)),
          }
    )
     );
  }
}
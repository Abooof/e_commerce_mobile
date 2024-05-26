import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../helpers/helperFunctions.dart';
import '../providers/AuthProvider.dart';
import '../screens/AllProductsScreen.dart';
import '../screens/AddProductScreen.dart';
import '../screens/FavouriteScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/profileScreen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late NavigationController controller;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    controller = Get.put(NavigationController(authProvider.role));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context);
    authProvider.addListener(() {
      controller.updateRole(authProvider.role);
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.amber : Colors.white,
          indicatorColor: darkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          destinations: _buildDestinations(authProvider.role),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  List<NavigationDestination> _buildDestinations(String role) {
    List<NavigationDestination> destinations = [
      NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
      NavigationDestination(icon: Icon(Iconsax.box), label: 'All Products'),
    ];

    if (role == 'vendor') {
      destinations.add(
          NavigationDestination(icon: Icon(Iconsax.add_square), label: 'Add Product'));
      destinations.add(
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'));  
    } else if (role == 'user') {
<<<<<<< HEAD
      // destinations.add(
      //     const NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favourite'));
=======
      destinations.add(
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favourite'));
>>>>>>> parent of ebcf0ca (profile finshed for user and vendor excpt the image is not saved)
      destinations.add(
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'));
    } 

    return destinations;
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late List<Widget> screens;

  NavigationController(String role) {
    screens = _initializeScreens(role);
  }

  void updateRole(String role) {
    screens = _initializeScreens(role);
    selectedIndex.value = 0; // Reset to the home screen
  }

  List<Widget> _initializeScreens(String role) {
    switch (role) {
      case 'vendor':
        return [
          const HomeScreen(),
          AllProductsScreen(),
          AddProductScreen(),
          const ProfileScreen(),
        ];
      case 'user':
        return [
          const HomeScreen(),
<<<<<<< HEAD
          const AllProductsScreen(),
          // const FavouriteScreen(),
=======
          AllProductsScreen(),
          const FavouriteScreen(),
>>>>>>> parent of ebcf0ca (profile finshed for user and vendor excpt the image is not saved)
          const ProfileScreen(),
        ];
      default:
        return [
          const HomeScreen(),
          AllProductsScreen(),
        ];
    }
  }
}

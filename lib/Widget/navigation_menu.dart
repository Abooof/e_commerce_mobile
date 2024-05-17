import 'package:e_commerce_mobile/helpers/helperFunctions.dart';
import 'package:e_commerce_mobile/screens/homeScreen.dart';
import 'package:e_commerce_mobile/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../screens/FavouriteScreen.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.amber : Colors.white,
          indicatorColor: darkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
          
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}


class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

   final screens = [const HomeScreen() , const FavouriteScreen() , const ProfileScreen() ]; //, const SettingsScreen()
}
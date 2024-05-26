import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../helpers/Colors.dart';
import '../helpers/allTexts.dart';
import '../providers/AuthProvider.dart';
import '../screens/CartScreen.dart';
import '../screens/loginSignUpScreen.dart';

class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return AppBar(
      // Conditionally show login or logout button
      leading: IconButton(
        icon: Icon(
          authProvider.isAuthenticated ? Iconsax.logout : Iconsax.login,
          color: Colors.black,
        ),
        onPressed: () {
          if (authProvider.isAuthenticated) {
            _showLogoutDialog(context, authProvider);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginSignUpScreen()),
            );
          }
        },
      ),
      title: Text(
        AllTexts.homeAppbarTitle,
        style: Theme.of(context).textTheme.labelMedium!.apply(color: AllColors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Iconsax.shopping_bag, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                authProvider.logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

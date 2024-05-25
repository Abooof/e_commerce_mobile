import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../helpers/Colors.dart';
import '../helpers/allTexts.dart';
import '../providers/AuthProvider.dart';
import '../screens/CartScreen.dart';
import '../screens/loginSignUpScreen.dart';

class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return AppBar(
      leading: authProvider.isAuthenticated
          ? IconButton(
              icon: const Icon(Iconsax.logout, color: Colors.black),
              onPressed: () {
                authProvider.logout();
                // Optionally, you can navigate the user to the login screen or show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You have been logged out')),
                );
              },
            )
          : IconButton(
              icon: const Icon(Iconsax.login, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
                );
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
        if (authProvider.isAuthenticated)
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

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
    final authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      // Add icon button login to AppBar leading position and navigate to login screen when clicked on it
      leading: IconButton(
        icon: const Icon(Iconsax.login, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginSignUpScreen()), // Login screen
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
        if (authProvider.role == "user")
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

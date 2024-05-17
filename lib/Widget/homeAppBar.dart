import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../helpers/Colors.dart';
import '../helpers/allTexts.dart';
import '../screens/CartScreen.dart';


class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
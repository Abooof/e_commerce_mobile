//create home screen for e-commerce app

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../Widget/homeAppBar.dart';
import '../helpers/Sizes.dart';

import '../helpers/search.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            THomeAppBar(),
            SizedBox(height: Allsizes.spaceBtwSections),
            Text('Profile Screen'),
            
          ],
        ),
      ),
    );
  }
}

//create cart screen for e-commerce app
//
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../Widget/navigation_menu.dart';
import '../helpers/search.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  //create getter for the cart screen widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Cart Screen', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

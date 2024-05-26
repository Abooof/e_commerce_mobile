<<<<<<< HEAD
import 'package:e_commerce_mobile/models/user_model.dart';
import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:e_commerce_mobile/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
=======
//create cart screen for e-commerce app
//
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
>>>>>>> parent of ebcf0ca (profile finshed for user and vendor excpt the image is not saved)

import '../Widget/navigation_menu.dart';
import '../helpers/search.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
<<<<<<< HEAD

  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
=======
  //create getter for the cart screen widget

>>>>>>> parent of ebcf0ca (profile finshed for user and vendor excpt the image is not saved)
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final currentUser = authProvider.currentUser;
    final cartItems = currentUser?.cart ?? [];

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text("Cart"),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = productProvider.getProductById(cartItems[index]);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            //   image: DecorationImage(
                            //   image: NetworkImage(product.imageUrl),
                            //  fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // productProvider.removeFromCart(product.id, currentUser!);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${productProvider.calculateTotalPrice(currentUser!).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Your order is being processed'),
                ),
              );
            },
            child: const Text(
              'Checkout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
=======
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
>>>>>>> parent of ebcf0ca (profile finshed for user and vendor excpt the image is not saved)
      ),
    );
  }
}

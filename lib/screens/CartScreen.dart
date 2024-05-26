import 'package:e_commerce_mobile/models/product_model.dart';
import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:e_commerce_mobile/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cart'),
      ),
      body: FutureBuilder(
        future: productProvider.getCartProducts(
            authProvider.currentUser!, authProvider.token),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Product>? cartProducts = snapshot.data;
            if (cartProducts == null || cartProducts.isEmpty) {
              return Center(child: Text('No products in the cart.'));
            } else {
              // Calculate total price
              double totalPrice = cartProducts.fold<double>(
                0,
                (previousValue, product) => previousValue + product.price,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product product = cartProducts[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                              'Price: \$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Remove product from cart when delete button is pressed
                              productProvider.removeFromCart(
                                  product.id,
                                  authProvider.currentUser!,
                                  authProvider.token,
                                  context);
                              setState(() {}); // Trigger UI rebuild
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      height:
                          20), // Add some space between total price and checkout button
                  ElevatedButton(
                    onPressed: () {
                      // Clear cart when checkout button is clicked
                      productProvider.clearCart(authProvider.currentUser!,
                          authProvider.token, context);
                      setState(() {}); // Trigger UI rebuild
                      // Show popup when checkout button is clicked
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Checkout"),
                            content: Text("Order placed"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Checkout'),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

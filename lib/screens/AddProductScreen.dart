import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameValue = TextEditingController();
  final priceValue = TextEditingController();
  final quantityValue = TextEditingController();
    final categoryValue = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Accessing the ProductProvider
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false); 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new product"),
        backgroundColor: Colors.deepPurple, // Match your theme
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              try {
                await productProvider.addProduct(
                  nameValue.text,
                  double.parse(priceValue.text),
                  int.parse(quantityValue.text),
                  categoryValue.text,
                  authProvider.DBid,
                  authProvider.token
                );
                // Success message (Optional)
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Product added!")));
              } catch (err) {
                // Error handling
                showDialog<Null>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('An error occurred!'),
                    content: Text(err.toString()),
                    actions: [
                      TextButton(
                        child: const Text('Okay'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      )
                    ],
                  ),
                );
              } finally {
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Name'),
                    controller: nameValue,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    controller: priceValue,
                    keyboardType: TextInputType.number, // For numeric input
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    controller: quantityValue,
                    keyboardType: TextInputType.number, // For numeric input
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Category'),
                    controller:
                        categoryValue, // Add a new controller for category
                  ),
                ],
              ),
            ),
    );
  }
}

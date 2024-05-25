import 'dart:io';

import 'package:flutter/material.dart';
import 'package:e_commerce_mobile/models/vendor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/vendor_provider.dart';



class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  final Vendor vendor = Vendor(
    name: "Vendor Name",
    description: "Vendor Description",
    products: [
      Product(name: "Product 1", description: "Description 1", price: 10.0, imageUrl: "https://via.placeholder.com/150"),
      // Add more products as needed
    ],
  );
// Inside _VendorProfileScreenState class
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Corrected method name

    if (pickedFile != null) {
      setState(() {
        // Assuming you have a method to upload the image and get the URL
        final imageUrl = uploadImage(File(pickedFile.path));
        final newProduct = Product(name: "New Product", description: "New Description", price: 20.0, imageUrl: imageUrl);
        context.read<VendorProvider>().addProduct(newProduct);
      });
    }
  }

  String uploadImage(File image) {
    // Implement your image upload logic here
    return "https://via.placeholder.com/150";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Vendor Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vendor.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(vendor.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text("Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: vendor.products.length,
                itemBuilder: (context, index) {
                  final product = vendor.products[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

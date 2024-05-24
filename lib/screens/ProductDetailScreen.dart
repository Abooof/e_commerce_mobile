import 'package:flutter/material.dart';
import '../models/product_model.dart';
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen(this.product);

  // ... rest of the code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Text('Price: \$${product.price}'),
          Text('Quantity: ${product.quantity}'),
        ],
      ),
    );
  }
}


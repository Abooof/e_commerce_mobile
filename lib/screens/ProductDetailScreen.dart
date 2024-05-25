import 'package:e_commerce_mobile/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Price: \$${product.price}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Quantity: ${product.quantity}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Average Rating: ${product.averageRating.toStringAsFixed(1)}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () {
                        int rating = index + 1;
                        productProvider.rateProduct(product.id, rating).then((_) {
                          // Refresh the UI after rating
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Thank you for rating!')),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to rate the product: $error')),
                          );
                        });
                      },
                      icon: Icon(
                        Icons.star,
                        color: index < product.averageRating.round() ? Colors.orange : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:e_commerce_mobile/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    String newComment = ''; // Local variable to store the new comment
    final authProvider = Provider.of<AuthProvider>(context);

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
                        productProvider.rateProduct(product.id, rating,authProvider.DBid,authProvider.token).then((_) {
                          // Refresh the UI after rating
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Thank you for rating!')),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Comments:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: product.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(product.comments[index]),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          newComment = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (newComment.isNotEmpty) {
                          productProvider.addComment(product.id, newComment,authProvider.token).then((_) {
                            // Refresh the UI after adding the comment
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Comment added successfully!')),
                            );
                            newComment = ''; // Clear the comment field after adding the comment
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to add comment: $error')),
                            );
                          });
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

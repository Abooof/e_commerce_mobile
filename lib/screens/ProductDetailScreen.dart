import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:e_commerce_mobile/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen(this.productId, {super.key});

  @override
  Widget build(BuildContext context) {
    String newComment = ''; // Local variable to store the new comment
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.DBid; // Assume this gets the current user ID

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false).fetchProductById(productId, authProvider.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                final product = productProvider.getProductById(productId);
                final userRating = product.userRating(userId); // Get the user's rating

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
                    if  (authProvider.role != 'vendor') // Show the rating UI only if the user is not a vendor
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: List.generate(
                            5,
                            (index) => IconButton(
                              onPressed: () {
                                int rating = index + 1;
                                productProvider.rateProduct(product.id, rating, authProvider.DBid, authProvider.token).then((_) {
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
                                color: index < userRating ? Colors.orange : Colors.grey, // Highlight stars based on user's rating
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
                                productProvider.addComment(product.id, newComment, authProvider.token).then((_) {
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
            );
          }
        },
      ),
    );
  }
}

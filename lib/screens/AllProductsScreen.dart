import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';
import 'ProductDetailScreen.dart';

class AllProductsScreen extends StatefulWidget {
  static const routeName = '/all-products';

  const AllProductsScreen({super.key});

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    var myProvider = Provider.of<ProductProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    myProvider.fetchProduceFromServer(authProvider.token);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final products = productProvider.getAllProduce;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/addProduct');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(products[index].name),
          subtitle: Text(
              'Price: \$${products[index].price}, Quantity: ${products[index].quantity}, Category: ${products[index].category}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Call the method to add product to cart
                  productProvider.addToCart(products[index].id, authProvider.currentUser! , context);
                  // Show popup
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Product added to cart.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete Product'),
                      content:
                          const Text('Are you sure you want to delete this product?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Call the delete function from your provider
                            productProvider.deleteProduce(products[index].id);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(products[index]),
            ),
          ),
        ),
      ),
    );
  }
}

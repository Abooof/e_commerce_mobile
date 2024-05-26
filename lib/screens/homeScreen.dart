import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../Widget/homeAppBar.dart';
import '../helpers/Sizes.dart';
import '../helpers/search.dart';
import '../providers/AuthProvider.dart';
import '../providers/productProvider.dart';
import 'ProductDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.role == 'vendor') {
      productProvider.get_my_product(authProvider.DBid, authProvider.token);
    } else {
      productProvider.fetchProduceFromServer(authProvider.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    final products = productProvider.getAllProduce;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const THomeAppBar(),
            const SizedBox(height: Allsizes.spaceBtwSections),
            const TSearchContainer(text: 'Search for products'),
            const SizedBox(height: Allsizes.spaceBtwSections),
            products.isEmpty
                ? const Center(child: Text('No products available.'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (ctx, index) => ListTile(
                      title: Text(products[index].name),
                      subtitle: Text(
                        'Price: \$${products[index].price}, Quantity: ${products[index].quantity}, Category: ${products[index].category}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (authProvider.isAuthenticated && authProvider.role == 'user')
                            IconButton(
                              icon: const Icon(Icons.shopping_cart),
                              onPressed: () {
                                productProvider.addToCart(products[index].id, authProvider.currentUser!, context);
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
                          if (authProvider.role == 'vendor')
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Delete Product'),
                                    content: const Text('Are you sure you want to delete this product?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          productProvider.deleteProduce(products[index].id, authProvider.token);
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
          ],
        ),
      ),
    );
  }
}

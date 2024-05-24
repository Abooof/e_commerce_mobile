import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';

class AllProductsScreen extends StatefulWidget {
  static const routeName = '/all-products';

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}
class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProduceFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.getAllProduce;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/addProduct');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: productProvider.fetchProduceFromServer,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(products[index].name),
              subtitle: Text('Price: \$${products[index].price}, Quantity: ${products[index].quantity}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Delete'),
                        content: Text('Are you sure you want to delete this product?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              productProvider.deleteProduce(products[index].id);
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
  
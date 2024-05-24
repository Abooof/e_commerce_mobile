import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';
import 'ProductDetailScreen.dart';

class AllProductsScreen extends StatefulWidget {
  static const routeName = '/all-products';

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProduceFromServer();
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
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(products[index].name),
          subtitle: Text(
              'Price: \$${products[index].price}, Quantity: ${products[index].quantity}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => {
              // Delete functionality
            },
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

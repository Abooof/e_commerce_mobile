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
              Navigator.of(context).pushNamed('/add-product');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: productProvider.fetchProduceFromServer,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
              key: ValueKey(products[index].id),
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                productProvider.deleteProduce(products[index].id);
              },
              child: ListTile(
                title: Text(products[index].name),
                subtitle: Text('Price: \$${products[index].price}, Quantity: ${products[index].quantity}'),
              ),
            );
          },
        ),
      ),
    );
  }
}

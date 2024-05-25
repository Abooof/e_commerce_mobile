class Vendor {
  String name;
  String description;
  List<Product> products;

  Vendor({required this.name, required this.description, required this.products});
}

class Product {
  String name;
  String description;
  double price;
  String imageUrl;

  Product({required this.name, required this.description, required this.price, required this.imageUrl});
}

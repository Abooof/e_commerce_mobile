import 'package:flutter/material.dart';
import 'package:e_commerce_mobile/models/vendor.dart';

class VendorProvider with ChangeNotifier {
  Vendor _vendor = Vendor(name: "Vendor Name", description: "Vendor Description", products: []);

  Vendor get vendor => _vendor;

  void addProduct(Product product) {
    _vendor.products.add(product);
    notifyListeners();
  }
}

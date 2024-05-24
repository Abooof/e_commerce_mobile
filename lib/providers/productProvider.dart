import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _produceList = [];
  final produceURL = Uri.parse(
      'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product.json'); // Update with your actual URL

  Future<void> fetchProduceFromServer() async {
    try {
      var response = await http.get(produceURL);
      var fetchedData = json.decode(response.body) as Map<String, dynamic>;
      _produceList.clear();
      fetchedData.forEach((key, value) {
        _produceList.add(Product(
          id: key,
          name: value['name'],
          price: value['price'],
          quantity: value['quantity'],
        ));
      });
      notifyListeners();
    } catch (err) {
      print("Error fetching produce: $err");
    }
  }

  Future<void> addProduct(String name, double price, int quantity) async {
    try {
      var response = await http.post(
        produceURL,
        body: json.encode({
          'name': name,
          'price': price,
          'quantity': quantity,
        }),
      );

      var responseData = json.decode(response.body);
      if (responseData == null || responseData['name'] == null) {
        throw 'Failed to add product. Server response is null or missing.';
      }

      var newProduct = Product(
        id: responseData['name'],
        name: name,
        price: price,
        quantity: quantity,
      );
      _produceList.add(newProduct);
      notifyListeners();
    } catch (err) {
      print("Error adding produce: $err");
      throw err;
    }
  }

  List<Product> get getAllProduce {
    return [..._produceList];
  }

  void deleteProduce(String idToDelete) async {
    var produceToDeleteURL = Uri.parse(
        'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$idToDelete.json'); // Update with your actual URL
    try {
      await http.delete(produceToDeleteURL);
      _produceList.removeWhere((element) => element.id == idToDelete);
      notifyListeners();
    } catch (err) {
      print("Error deleting produce: $err");
    }
  }
}

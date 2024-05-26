import 'package:e_commerce_mobile/models/user_model.dart';
import 'package:e_commerce_mobile/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _produceList = [];
  
  Future<void> fetchProduceFromServer(String token) async {
    try {
      var produceURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product.json');
      var response = await http.get(produceURL);

      var fetchedData = json.decode(response.body) as Map<String, dynamic>?;

      _produceList.clear();
      fetchedData?.forEach((key, value) {
        try {
          _produceList.add(Product(
            id: key,
            name: value['name'],
            price: value['price'],
            quantity: value['quantity'],
            category: value['category'],
          ));
        } catch (e) {
          print("Error parsing product data: $e");
        }
      });

      notifyListeners();
    } catch (err) {
      print("Error fetching produce: $err");
    }
  }

  Future<void> addProduct(String name, double price, int quantity,
      String category, String token) async {
    try {
      print("token:  $token ");
      var produceURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product.json?auth=$token');
      print("produceURL: $produceURL");

      var response = await http.post(
        produceURL,
        body: json.encode({
          'name': name,
          'price': price,
          'quantity': quantity,
          'category': category, // Add category to request body
        }),
      );
      print("Response: ${response.body}");

      var responseData = json.decode(response.body);
      if (responseData == null || responseData['name'] == null) {
        throw 'Failed to add product. Server response is null or missing.';
      }
      print("Fetched Data: $responseData");

      var newProduct = Product(
        id: responseData['name'],
        name: name,
        price: price,
        quantity: quantity,
        category: category, // Initialize category
      );
      _produceList.add(newProduct);
      notifyListeners();
    } catch (err) {
      print("Error adding produce: $err");
      rethrow;
    }
  }

  // Other methods remain unchanged...

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

  Future<void> rateProduct(String productId, int rating) async {
    try {
      var productURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$productId.json');
      var response = await http.get(productURL);
      if (response.statusCode == 200) {
        var productData = json.decode(response.body);
        print(productData); // Log the fetched data

        List<dynamic> ratings = productData['ratings'] ?? [];
        ratings.add(rating);

        var updateResponse = await http.patch(
          productURL,
          body: json.encode({'ratings': ratings}),
        );

        if (updateResponse.statusCode == 200) {
          _produceList
              .firstWhere((prod) => prod.id == productId)
              .addRating(rating);
          notifyListeners();
        } else {
          throw 'Failed to rate product';
        }
      } else {
        throw 'Failed to fetch product data';
      }
    } catch (err) {
      print("Error rating product: $err");
      rethrow;
    }
  }

  Future<void> addComment(String productId, String comment) async {
    try {
      var productURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$productId.json');
      var response = await http.get(productURL);
      if (response.statusCode == 200) {
        var productData = json.decode(response.body);
        List<dynamic> comments = productData['comments'] ?? [];
        comments.add(comment);

        var updateResponse = await http.patch(
          productURL,
          body: json.encode({'comments': comments}),
        );

        if (updateResponse.statusCode == 200) {
          _produceList.firstWhere((prod) => prod.id == productId).comments =
              List<String>.from(comments);
          notifyListeners();
        } else {
          throw 'Failed to add comment';
        }
      } else {
        throw 'Failed to fetch product data';
      }
    } catch (err) {
      print("Error adding comment: $err");
      rethrow;
    }
  }

  List<String> getProductComments(String productId) {
    return _produceList.firstWhere((prod) => prod.id == productId).comments;
  }
Future<void> addToCart(String productId, UserModel currentUser, BuildContext context) async {
    try {
      // Add productId to the user's cart list
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

      currentUser.cart ??= []; // Initialize cart list if null
      currentUser.cart!.add(productId);
  print(authProvider.DBid);
      // Update user's data on the server
      final updateUserUrl = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/user/${authProvider.DBid}.json');
            print("updateUserUrl: $updateUserUrl");

      final updateResponse = await http.patch(
        updateUserUrl,
        body: json.encode({'cart': currentUser.cart}),
      );

      if (updateResponse.statusCode != 200) {
        throw 'Failed to update user cart';
      }

      // Notify listeners that the data has changed
      notifyListeners();
    } catch (error) {
      print("Error adding to cart: $error");
      rethrow;
    }
  }
  
  }

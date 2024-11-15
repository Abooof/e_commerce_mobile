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
            vendorID: value['vendorID'],
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

  Future<void> get_my_product(vendoriD, String token) async {
    try {
      var produceURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product.json');
      var response = await http.get(produceURL);

      var fetchedData = json.decode(response.body) as Map<String, dynamic>?;

      _produceList.clear();
      fetchedData?.forEach((key, value) {
        try {
          if (value['vendorID'] == vendoriD) {
            _produceList.add(Product(
              id: key,
              name: value['name'],
              price: value['price'],
              quantity: value['quantity'],
              category: value['category'],
              vendorID: value['vendorID'],
              ratings: value['ratings'] != null
                  ? List<int>.from(value['ratings'])
                  : [],
              ratedUserIds: value['ratedUserIds'] != null
                  ? Set<String>.from(value['ratedUserIds'])
                  : {},
              comments: value['comments'] != null
                  ? List<String>.from(value['comments'])
                  : [],
            ));
          }
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
      String category, String vendorid, String token) async {
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
          'category': category,
          "vendorID": vendorid,
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
        category: category,
        vendorID: vendorid,
      );
      _produceList.add(newProduct);
      notifyListeners();
    } catch (err) {
      print("Error adding produce: $err");
      rethrow;
    }
  }

  // Other methods remain unchanged...

  Future<void> fetchProductById(String productId, String token) async {
    try {
      var productURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$productId.json?auth=$token');
      var response = await http.get(productURL);
      if (response.statusCode == 200) {
        print("iiiiiiin");
        var productData = json.decode(response.body);
        print(productData);
        var updatedProduct = Product(
          id: productId,
          name: productData['name'],
          price: productData['price'],
          quantity: productData['quantity'],
          category: productData['category'],
          vendorID: productData['vendorID'],
          ratings: productData['ratings'] != null
              ? List<int>.from(productData['ratings']
                  .map((ratingData) => ratingData['rating']))
              : [],
          ratedUserIds: productData['ratedUserIds'] != null
              ? Set<String>.from(productData['ratedUserIds'])
              : {},
          comments: productData['comments'] != null
              ? List<String>.from(productData['comments'])
              : [],
        );
        print("innnnnnnnn");
        _produceList.removeWhere((prod) => prod.id == productId);
        _produceList.add(updatedProduct);
        notifyListeners();
      } else {
        throw 'Failed to fetch product data';
      }
    } catch (err) {
      print("Error fetching product: $err");
      rethrow;
    }
  }

  // Add other methods as needed...

  List<Product> get getAllProduce {
    return [..._produceList];
  }

  Product getProductById(String productId) {
    return _produceList.firstWhere((prod) => prod.id == productId);
  }

  void deleteProduce(String idToDelete, String token) async {
    print("idToDelete $idToDelete");
    var produceToDeleteURL = Uri.parse(
        'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$idToDelete.json?auth=$token'); // Update with your actual URL
    try {
      print(produceToDeleteURL);
      await http.delete(produceToDeleteURL);
      _produceList.removeWhere((element) => element.id == idToDelete);
      notifyListeners();
    } catch (err) {
      print("Error deleting produce: $err");
    }
  }

  Future<void> rateProduct(
      String productId, int rating, String userId, String token) async {
    try {
      var productURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$productId.json?auth=$token');
      print(productURL);
      var response = await http.get(productURL);
      if (response.statusCode == 200) {
        var productData = json.decode(response.body);
        List<dynamic> ratings = productData['ratings'] ?? [];
        Set<String> ratedUserIds =
            Set<String>.from(productData['ratedUserIds'] ?? []);
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>1");
        // Check if the user has already rated the product
        if (ratedUserIds.contains(userId)) {
          // If the user has already rated, find and update their existing rating
          int userRatingIndex =
              ratings.indexWhere((rating) => rating['userId'] == userId);
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>2");

          if (userRatingIndex != -1) {
            ratings[userRatingIndex]['rating'] = rating;
          }
        } else {
          // If the user has not rated, add their rating
          ratings.add({'userId': userId, 'rating': rating});
          ratedUserIds.add(userId);
        }
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>3");

        var updateResponse = await http.patch(
          productURL,
          body: json.encode({
            'ratings': ratings,
            'ratedUserIds': [...ratedUserIds],
          }),
        );
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>4");
        print(updateResponse.body);

        if (updateResponse.statusCode == 200) {
          _produceList.firstWhere((prod) => prod.id == productId).ratings =
              ratings.map<int>((e) => e['rating']).toList();
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

  Future<void> addComment(
      String productId, String comment, String token) async {
    try {
      var productURL = Uri.parse(
          'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$productId.json?auth=$token');
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

  Future<void> addToCart(
      String productId, UserModel currentUser, BuildContext context) async {
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

  Future<List<Product>> getCartProducts(
      UserModel currentUser, String token) async {
    List<Product> cartProducts = [];

    try {
      if (currentUser.cart == null || currentUser.cart!.isEmpty) {
        return cartProducts; // Return empty list if cart is null or empty
      }

      for (String productId in currentUser.cart!) {
        // Fetch product details for each productId in the cart
        var productURL = Uri.parse(
            'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/product/$productId.json?auth=$token');
        var response = await http.get(productURL);
        if (response.statusCode == 200) {
          var productData = json.decode(response.body);
          print("productData $productData");

          Product product = Product(
            id: productId,
            name: productData['name'],
            price: productData['price'],
            quantity: productData['quantity'],
            category: productData['category'],
            vendorID: productData['vendorID'],
            ratings: (productData['ratings'] != null &&
                    productData['ratings'] is int)
                ? List<int>.from(productData['ratings'])
                : [],
            ratedUserIds: (productData['ratedUserIds'] != null &&
                    productData['ratedUserIds'] is Set<String>)
                ? Set<String>.from(productData['ratedUserIds'])
                : {},
            comments: (productData['comments'] != null &&
                    productData['comments'] is List<String>)
                ? List<String>.from(productData['comments'])
                : [],
          );


          cartProducts.add(product);
          print(cartProducts);
        } else {
          print("Failed to fetch product data for productId: $productId");
        }
      }
    } catch (err) {
      print("Error fetching cart products: $err");
    }

    return cartProducts;
  }
    Future<void> removeFromCart(String productId, UserModel currentUser, String token,BuildContext context) async {
    try {
      // Remove productId from the user's cart list
      currentUser.cart?.remove(productId);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Update user's data on the server
      final updateUserUrl = Uri.parse('https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/user/${authProvider.DBid}.json');
      
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
      print("Error removing from cart: $error");
      rethrow;
    }
  }

  void clearCart(UserModel currentUser, String token, BuildContext context) async {
    try {
      // Clear the cart data in the user's profile
      currentUser.cart?.clear();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Update user's data on the server
      final updateUserUrl = Uri.parse('https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/user/${authProvider.DBid}.json');
      
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
      print("Error clearing cart: $error");
      rethrow;
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_mobile/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  String _token = "";
  DateTime _expiryDate = DateTime.utc(1970);
  String _userId = "";
  bool _authenticated = false;
  UserModel? _currentUser;

  bool get isAuthenticated {
    return _authenticated;
  }

  String get token {
    if (_expiryDate != DateTime.utc(1970) &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return "";
  }

  String get userId {
    return _userId;
  }

  String get role {
    return _currentUser?.role ?? "";
  }

  UserModel? get currentUser {
    return _currentUser;
  }

  Future<void> signUp(
      String email,
      String displayName,
      String role,
      String profilePicture,
      String address,
      String phoneNumber,
      String password,
      String? shopName,
      String? shopDescription,
      String? shopLocation) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBE56TSTHe3qnWkYv0cbyxi19_w14SH3qY');
    final databaseUrl = Uri.parse(
        'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/user.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>?;
      if (responseData == null || responseData.containsKey('error')) {
        throw Exception(responseData?['error']['message'] ?? 'Unknown error');
      }
      _authenticated = true;
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );

      final databaseResponse = await http.post(
        databaseUrl,
        body: json.encode({
          'email': email,
          'role': role,
          'displayName': displayName,
          'profilePicture': profilePicture,
          'address': address,
          'phoneNumber': phoneNumber,
          'wishlist': [],
          'cart': [],
          'shopName': shopName,
          'shopDescription': shopDescription,
          'shopLocation': shopLocation,
          '_userId': _userId,
        }),
      );

      final databaseResponseData =
          json.decode(databaseResponse.body) as Map<String, dynamic>?;
      print("Database response: $databaseResponseData");
      if (databaseResponseData == null ||
          databaseResponseData.containsKey('error')) {
        throw Exception(
            databaseResponseData?['error']['message'] ?? 'Unknown error');
      }

      notifyListeners();
    } catch (error) {
      print("The error is: $error");
      throw error;
    }
  }

  //--------------------Login--------------------

  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final databaseUrl = Uri.parse(
      'https://ecommerce-mobile-195ff-default-rtdb.firebaseio.com/user.json',
    );

    try {
      final response = await http.get(databaseUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print(responseData);
      // Iterate through all users to find the one with the matching email
      final user = responseData.values.firstWhere(
        (userData) => userData['email'] == email,
        orElse: () => null,
      );

      if (user == null) {
        throw Exception('User not found');
      }

      return user as Map<String, dynamic>; // Cast user to Map<String, dynamic>
    } catch (error) {
      print('Error fetching user by email: $error');
      throw error;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authUrl = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBE56TSTHe3qnWkYv0cbyxi19_w14SH3qY');

    try {
      print("Email: $email, Password: $password");
      final authResponse = await http.post(
        authUrl,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final authResponseData =
          json.decode(authResponse.body) as Map<String, dynamic>?;
      print("Auth response: $authResponseData");
      if (authResponseData == null || authResponseData.containsKey('error')) {
        throw Exception(
            authResponseData?['error']['message'] ?? 'Unknown error');
      }

      _authenticated = true;
      _token = authResponseData['idToken'];
      _userId = authResponseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(authResponseData['expiresIn']),
        ),
      );
      final userData = await getUserByEmail(email);

      notifyListeners();

      return userData;
    } catch (error) {
      print("The error is: $error");
      throw error;
    }
  }

  Future<void> logout() async {
    _authenticated = false;
    _token = "";
    _userId = "";
    _expiryDate = DateTime.utc(1970);
    _currentUser = null;
    notifyListeners();
  }
}

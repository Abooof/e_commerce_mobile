class UserModel {
  String email;
  String displayName;
  String role; // shopper and Vendor
  String profilePicture;
  String address;
  String phoneNumber;
  String? shopName;
  String? shopDescription;
  String? shopLocation;
  List<String>? wishlist;
  List<String>? cart;

  UserModel({
    required this.email,
    required this.displayName,
    required this.role,
    required this.profilePicture,
    required this.address,
    required this.phoneNumber,
    this.shopName,
    this.shopDescription,
    this.shopLocation,
    this.wishlist,
    this.cart,
  });

  // Factory method to create a UserModel from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      profilePicture: json['profilePicture'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      shopName: json['role'] == 'vendor' ? json['shopName'] : null,
      shopDescription: json['role'] == 'vendor' ? json['shopDescription'] : null,
      shopLocation: json['role'] == 'vendor' ? json['shopLocation'] : null,
      wishlist: json['wishlist'] != null ? List<String>.from(json['wishlist']) : null,
      cart: json['cart'] != null ? List<String>.from(json['cart']) : null,
    );
  }

  // Method to convert a UserModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final data = {
      'email': email,
      'displayName': displayName,
      'role': role,
      'profilePicture': profilePicture,
      'address': address,
      'phoneNumber': phoneNumber,
      'wishlist': wishlist,
      'cart': cart,
    };
    
    if (role == 'vendor') {
      data['shopName'] = shopName;
      data['shopDescription'] = shopDescription;
      data['shopLocation'] = shopLocation;
    }
    
    return data;
  }
}

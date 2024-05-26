class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String category; // New field for category
  final String vendorID;
    List<int> ratings;
  Set<String> ratedUserIds;
  List<String> comments;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category, // Initialize category
    required this.vendorID,

    List<int>? ratings,
    Set<String>? ratedUserIds,
    List<String>? comments,
  })  : ratings = ratings ?? [],
        ratedUserIds = ratedUserIds ?? {},
        comments = comments ?? [];

  double get averageRating {
    if (ratings.isEmpty) {
      return 0.0;
    } else {
      double total = ratings.reduce((a, b) => a + b).toDouble();
      return total / ratings.length;
    }
  }

  void addRating(int rating) {
    ratings.add(rating);
  }
}
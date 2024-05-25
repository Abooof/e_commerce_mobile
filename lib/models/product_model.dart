class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  List<int> ratings;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    List<int>? ratings, // Allow ratings to be nullable
  }) : ratings = ratings ?? []; // Initialize ratings with an empty list if null

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

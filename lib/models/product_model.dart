class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  List<int> ratings;
  Set<String> ratedUserIds;
  List<String> comments; // New field to store comments

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
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

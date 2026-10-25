class Product {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isNew = false,
  });

  String get formattedPrice {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }
}
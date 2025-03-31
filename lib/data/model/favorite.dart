class Favorite {
  final String productId;
  final String productName;
  final int productPrice;
  final String category;
  final List<String> images;
  final String vendorId;
  final int productQuantity;
  int quantity;
  final String description;
  final String fullName;

  Favorite({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.images,
    required this.vendorId,
    required this.productQuantity,
    required this.quantity,
    required this.description,
    required this.fullName,
  });
}

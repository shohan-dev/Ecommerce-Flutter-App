class WishlistModels {
  String productId;
  bool isWishlist;

  WishlistModels({
    required this.productId,
    required this.isWishlist,
  });

  /// Empty Helper Function
  static WishlistModels empty() => WishlistModels(
        productId: '',
        isWishlist: false,
      );
  // convert model to json object
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'isWishlist': isWishlist,
    };
  }

  // convert json object to model if empty return empty model
  factory WishlistModels.fromsnapshot(Map<String, dynamic> document) {
    if (document.isNotEmpty) {
      return WishlistModels(
        productId: document['productId'] ?? '',
        isWishlist: document['isWishlist'] ?? false,
      );
    } else {
      // Handle the case where data is null, e.g., return an empty model or throw an exception
      return WishlistModels.empty();
    }
  }
}

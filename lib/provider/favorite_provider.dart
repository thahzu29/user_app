import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store/data/model/favorite.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite({
    required String productId,
    required String productName,
    required int productPrice,
    required String category,
    required List<String> images,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String description,
    required String fullName,
  }) {
    state[productId] = Favorite(
        productId: productId,
        productName: productName,
        productPrice: productPrice,
        category: category,
        images: images,
        vendorId: vendorId,
        productQuantity: productQuantity,
        quantity: quantity,
        description: description,
        fullName: fullName);

    // thông báo cho người dùng trạng thái đã thay đổi
    state = {...state};
  }

  // Xoa san pham khoi gio hang
  void removeFavoriteItem(String productId) {
    state.remove(productId);
    // trang thai  sau thay doi
    state = {...state};
  }

  Map<String, Favorite> get getFavortiteItems => state;
}

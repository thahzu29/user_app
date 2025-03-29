import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store/data/model/cart_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier,Map<String, Cart>>((ref){
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

  // Ham them san pham vao gio hang
  void addProductToCart({
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
    // Kiem tra neu san pham da co trong gio hang
    if (state.containsKey(productId)) {
      state = {
        ...state, // Sao chep trang thai hien tai
        productId: Cart(
          productId: state[productId]!.productId,
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          images: state[productId]!.images,
          vendorId: state[productId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          description: state[productId]!.description,
          fullName: state[productId]!.fullName,
        ),
      };
    } else {
      // Neu san pham chua co trong gio hang, them moi
      state = {
        ...state,
        productId: Cart(
          productId: productId,
          productName: productName,
          productPrice: productPrice,
          category: category,
          images: images,
          vendorId: vendorId,
          productQuantity: productQuantity,
          quantity: quantity,
          description: description,
          fullName: fullName,
        ),
      };
    }
  }

  // Ham tang so luong san pham
  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      // Trang thai sau thay doi
      state = {...state};
    }
  }

  // Ham giam so luong san pham
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      // trang thai sau thay doi
      state = {...state};
    }
  }

  // Xoa san pham khoi gio hang
  void removeCartItem(String productId) {
    state.remove(productId);
    // trang thai  sau thay doi
    state = {...state};
  }

  // tinh toan tong gia sau thay doi
  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }

  Map<String, Cart> get getCartItems => state;

  // xoa gio hang
  void clearCart(){
    state = {};
  }
}

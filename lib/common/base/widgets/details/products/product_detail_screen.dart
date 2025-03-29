import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_store/common/base/widgets/common/app_button.dart';
import 'package:multi_store/common/base/widgets/common/image_slider.dart';
import 'package:multi_store/data/model/product.dart';
import 'package:multi_store/provider/cart_provider.dart';
import 'package:multi_store/resource/theme/app_colors.dart';
import 'package:multi_store/resource/theme/app_style.dart';
import 'package:multi_store/services/manage_http_response.dart';
import '../../../../../resource/asset/app_images.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  bool _isFavorite = false;

  // Định dạng tiền tệ VNĐ
  String formatCurrency(int price) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return format.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.product.productName,
          style: AppStyles.STYLE_16_BOLD.copyWith(color: AppColors.blackFont),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            icon: SvgPicture.asset(
              _isFavorite ? AppImages.icHeartRed : AppImages.icHeart,
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlider(images: widget.product.images),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.productName,
                    style: AppStyles.STYLE_16_BOLD.copyWith(
                      color: AppColors.bluePrimary,
                    ),
                  ),
                  Text(
                    formatCurrency(widget.product.productPrice),
                    style: AppStyles.STYLE_16.copyWith(
                      color: AppColors.blackFont,
                    ),
                  ),
                ],
              ),
            ),
            widget.product.totalRatings == 0
                ? Text('')
                : Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 5),

                        Text(
                          widget.product.averageRating.toStringAsFixed(1),
                          style: AppStyles.STYLE_14_BOLD.copyWith(color: AppColors.blackFont),
                        ),
                        const SizedBox(width: 5),
                        Text("(${widget.product.totalRatings})"),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.product.category,
                style: AppStyles.STYLE_14_BOLD.copyWith(
                  color: AppColors.greyTextField,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Đặc điểm nổi bật",
                    style: AppStyles.STYLE_14_BOLD.copyWith(
                      color: AppColors.blackFont,
                    ),
                  ),
                  Text(
                    widget.product.description,
                    style: AppStyles.STYLE_14.copyWith(
                      color: AppColors.blackFont,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: SvgPicture.asset(
                _isFavorite ? AppImages.icHeartRed : AppImages.icHeart,
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(width: 5),
            AppButton(
              text: "Mua ngay",
              onPressed: () {},
              color: AppColors.black80,
              textColor: AppColors.white,
              height: 50,
              width: 130,
              fontSize: 14,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: "Thêm giỏ hàng",
              onPressed: () {
                if (isInCart == true) return;
                cartProviderData.addProductToCart(
                  productId: widget.product.id,
                  productName: widget.product.productName,
                  productPrice: widget.product.productPrice,
                  category: widget.product.category,
                  images: widget.product.images,
                  vendorId: widget.product.vendorId,
                  productQuantity: widget.product.quantity,
                  quantity: 1,
                  description: widget.product.id,
                  fullName: widget.product.fullName,
                );
                showSnackBar(context, "${widget.product.productName} đã thêm vào giỏ");
              },
              color: isInCart == true ? AppColors.grey : AppColors.bluePrimary,
              textColor: AppColors.white,
              height: 50,
              width: 145,
              fontSize: 13,
            )
          ],
        ),
      ),
    );
  }
}

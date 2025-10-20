// lib/components/product_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_essam_elmetwally/models/product_model.dart';
import '../app_theme.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductItem({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              style: textTheme.titleSmall!.copyWith(
                                color: AppTheme.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(width: 6),
                          SvgPicture.asset(
                            'assets/icons/%.svg',
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            product.price,
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product.oldPrice,
                            style: textTheme.bodySmall!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppTheme.grey,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/love.svg',
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/sell.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.soldCount,
                            style: textTheme.bodySmall!.copyWith(
                              color: AppTheme.black.withValues(alpha: .6),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/coins.svg',
                            width: 22,
                            height: 22,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppTheme.black),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/cart.svg',
                              width: 18,
                              height: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/images/logoimage.png',
                            width: 28,
                            height: 28,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

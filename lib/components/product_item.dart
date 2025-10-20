import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class ProductItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String oldPrice;
  final String soldCount;
  final TextTheme textTheme;

  const ProductItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.soldCount,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
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
                            title,
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                          price,
                          style: textTheme.titleSmall!.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          oldPrice,
                          style: textTheme.bodySmall!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppTheme.grey,
                          ),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/love.svg',
                          width: 18,
                          height: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/sell.svg',
                          width: 18,
                          height: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          soldCount,
                          style: textTheme.bodySmall!.copyWith(
                            color: AppTheme.black.withValues(alpha: .6),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const SizedBox(width: 8),

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

                        Image.asset(
                          'assets/images/logoimage.png',
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

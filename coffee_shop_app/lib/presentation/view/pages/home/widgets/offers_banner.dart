/* -----------------------------------------------------
   🎁 OffersBanner
   - Simple animated promo banner
   ----------------------------------------------------- */
import 'package:coffee_shop_app/core/helper/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class OffersBanner extends StatelessWidget {
  const OffersBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.95, end: 1.0),
        duration: const Duration(milliseconds: 450),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Opacity(opacity: (value - 0.94) * 15, child: child),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CustomNetworkImage(
                image:
                    "https://img.pikbest.com/backgrounds/20210623/coffee-shop-promotion-banner_6026970.jpg!sw800",
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  "Buy one get one FREE ☕",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
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

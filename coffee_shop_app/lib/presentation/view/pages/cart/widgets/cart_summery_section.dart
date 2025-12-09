import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/price_row_widget.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/checkout_page.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 💰 Bottom section showing promo code field, totals, and checkout button.
class CartSummarySection extends StatefulWidget {
  final CartLoaded state;

  const CartSummarySection({super.key, required this.state});

  @override
  State<CartSummarySection> createState() => _CartSummarySectionState();
}

class _CartSummarySectionState extends State<CartSummarySection> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final state = widget.state;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🎟 Promo code field
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    labelText: 'Promo Code',
                    labelStyle: TextStyle(color: theme.colorScheme.primary),
                    filled: true,
                    fillColor: isDark ? Colors.grey[800] : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: state.isPromoCodeLoading
                    ? null
                    : () {
                        final code = _promoController.text.trim();
                        if (code.isNotEmpty) {
                          context.read<CartViewModel>().applyPromoCode(code);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: state.isPromoCodeLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Apply'),
              ),
            ],
          ),

          if (state.promoCodeError != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                state.promoCodeError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),

          const SizedBox(height: 16),
          const Divider(),

          // 💵 Summary Rows
          PriceRowWidget(label: 'Subtotal:', value: state.subtotal),
          if (state.automaticDiscount > 0)
            PriceRowWidget(
              label: state.appliedOfferTitle,
              value: -state.automaticDiscount,
              color: Colors.green,
            ),
          if (state.promoCodeDiscount > 0)
            PriceRowWidget(
              label: 'Promo (${state.appliedPromoCode?.promoCode ?? ''})',
              value: -state.promoCodeDiscount,
              color: Colors.green,
            ),

          const Divider(),
          PriceRowWidget(
            label: 'Total:',
            value: state.finalTotal,
            isBold: true,
            size: 20,
          ),

          const SizedBox(height: 20),

          // 🧾 Checkout button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckoutPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

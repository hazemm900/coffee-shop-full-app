import 'package:flutter/material.dart';
import 'package:shared_data/entities/promotion.dart';

class PromotionDiscountSection extends StatelessWidget {
  final PromotionType type;
  final DiscountType discountType;
  final TextEditingController promoCodeController;
  final TextEditingController discountValueController;
  final ValueChanged<PromotionType?> onTypeChanged;
  final ValueChanged<DiscountType?> onDiscountTypeChanged;

  const PromotionDiscountSection({
    super.key,
    required this.type,
    required this.discountType,
    required this.promoCodeController,
    required this.discountValueController,
    required this.onTypeChanged,
    required this.onDiscountTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Discount Details'),
        _DropdownField<PromotionType>(
          label: 'Promotion Type',
          value: type,
          items: PromotionType.values,
          onChanged: onTypeChanged,
        ),
        if (type == PromotionType.PROMO_CODE)
          _TextField(
            controller: promoCodeController,
            label: 'Promo Code',
            required: true,
          ),
        _DropdownField<DiscountType>(
          label: 'Discount Type',
          value: discountType,
          items: DiscountType.values,
          onChanged: onDiscountTypeChanged,
        ),
        _TextField(
          controller: discountValueController,
          label: 'Discount Value',
          required: true,
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool required;

  const _TextField({
    required this.controller,
    required this.label,
    required this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (v) => v!.isEmpty ? '$label is required' : null
            : null,
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString().split('.').last),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_data/entities/promotion.dart';

class PromotionRulesSection extends StatelessWidget {
  final PromotionAppliesTo appliesTo;
  final TextEditingController minPurchaseController;
  final TextEditingController usageLimitController;
  final TextEditingController usagePerUserController;
  final ValueChanged<PromotionAppliesTo?> onAppliesToChanged;

  const PromotionRulesSection({
    super.key,
    required this.appliesTo,
    required this.minPurchaseController,
    required this.usageLimitController,
    required this.usagePerUserController,
    required this.onAppliesToChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Rules & Conditions'),
        _DropdownField<PromotionAppliesTo>(
          label: 'Applies To',
          value: appliesTo,
          items: PromotionAppliesTo.values,
          onChanged: onAppliesToChanged,
        ),
        _TextField(
          controller: minPurchaseController,
          label: 'Min Purchase (optional)',
        ),
        _TextField(
          controller: usageLimitController,
          label: 'Usage Limit (optional)',
        ),
        _TextField(
          controller: usagePerUserController,
          label: 'Usage Per User (optional)',
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _TextField({required this.controller, required this.label});

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

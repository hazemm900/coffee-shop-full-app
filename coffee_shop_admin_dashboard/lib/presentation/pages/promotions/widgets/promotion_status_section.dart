import 'package:flutter/material.dart';
import 'package:shared_data/entities/promotion.dart';

class PromotionStatusSection extends StatelessWidget {
  final PromotionStatus status;
  final ValueChanged<PromotionStatus?> onStatusChanged;

  const PromotionStatusSection({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Promotion Status'),
        DropdownButtonFormField<PromotionStatus>(
          value: status,
          decoration: const InputDecoration(
            labelText: 'Status',
            border: OutlineInputBorder(),
          ),
          items: PromotionStatus.values
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString().split('.').last),
                ),
              )
              .toList(),
          onChanged: onStatusChanged,
        ),
      ],
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

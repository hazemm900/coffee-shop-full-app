import 'package:flutter/material.dart';

class PromotionValiditySection extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final Future<void> Function({required bool isStart}) onPickDate;

  const PromotionValiditySection({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onPickDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Validity'),
        Row(
          children: [
            Expanded(
              child: _DateButton(
                label: 'Start',
                date: startDate,
                onPressed: () => onPickDate(isStart: true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DateButton(
                label: 'End',
                date: endDate,
                onPressed: () => onPickDate(isStart: false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DateButton extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onPressed;

  const _DateButton({
    required this.label,
    required this.date,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: Text('$label: ${date.toLocal().toString().split(' ')[0]}'),
      onPressed: onPressed,
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

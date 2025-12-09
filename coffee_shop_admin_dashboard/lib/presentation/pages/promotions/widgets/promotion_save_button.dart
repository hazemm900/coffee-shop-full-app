import 'package:flutter/material.dart';

class PromotionSaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSave;

  const PromotionSaveButton({
    super.key,
    required this.isLoading,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: isLoading ? null : onSave,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text('Save Promotion', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

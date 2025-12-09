import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwitchTile extends StatefulWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  late bool currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(widget.title),
        value: currentValue,
        activeColor: AppColors.primary,
        onChanged: (val) {
          setState(() => currentValue = val);
          widget.onChanged(val);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../../../core/theme/app_theme.dart';
import 'promotion_row.dart';

class PromotionsTable extends StatelessWidget {
  final List<Promotion> promotions;

  const PromotionsTable({super.key, required this.promotions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(AppColors.backgroundLight),
            headingTextStyle: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            columns: const [
              DataColumn(label: Text('Title')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Code')),
              DataColumn(label: Text('Value')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Expires')),
              DataColumn(label: Text('Actions')),
            ],
            rows: promotions.map((p) => buildPromotionRow(context, p)).toList(),
          ),
        ),
      ),
    );
  }
}

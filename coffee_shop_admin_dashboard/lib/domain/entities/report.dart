// admin_dashboard/lib/domain/entities/report.dart
import 'package:equatable/equatable.dart';

class DailyReport extends Equatable {
  final DateTime date;
  final double totalRevenue;
  final int orderCount;

  const DailyReport({
    required this.date,
    required this.totalRevenue,
    required this.orderCount,
  });

  // دالة مساعدة لحساب متوسط قيمة الطلب
  double get averageOrderValue =>
      orderCount > 0 ? totalRevenue / orderCount : 0.0;

  @override
  List<Object?> get props => [date, totalRevenue, orderCount];
}

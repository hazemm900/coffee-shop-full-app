import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/report.dart';

class DailyReportModel extends DailyReport {
  const DailyReportModel({
    required super.date,
    required super.totalRevenue,
    required super.orderCount,
  });

  factory DailyReportModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DailyReportModel(
      date: (data['date'] as Timestamp).toDate(),
      totalRevenue: (data['totalRevenue'] as num).toDouble(),
      orderCount: data['orderCount'] ?? 0,
    );
  }
}

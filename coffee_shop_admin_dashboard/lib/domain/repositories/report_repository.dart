import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/report.dart';

abstract class ReportRepository {
  // سنستخدم Stream هنا للحصول على تحديثات حية
  Stream<Either<Failure, DailyReport>> getDailyReportStream();
}

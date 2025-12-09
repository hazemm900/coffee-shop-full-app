import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/report.dart';
import '../repositories/report_repository.dart';

class GetDailyReportStreamUsecase {
  final ReportRepository repository;
  GetDailyReportStreamUsecase(this.repository);
  Stream<Either<Failure, DailyReport>> execute() =>
      repository.getDailyReportStream();
}

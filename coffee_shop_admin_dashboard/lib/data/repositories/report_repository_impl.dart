import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/firestore_datasource.dart';
import 'package:coffee_shop_admin_dashboard/data/models/report_model.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/report_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/entities/report.dart';
import 'package:dartz/dartz.dart';

class ReportRepositoryImpl implements ReportRepository {
  final FirestoreDataSource dataSource;
  ReportRepositoryImpl(this.dataSource);

  @override
  Stream<Either<Failure, DailyReport>> getDailyReportStream() {
    return dataSource
        .getDailyReportStream()
        .map<Either<Failure, DailyReport>>((snapshot) {
          try {
            if (snapshot.exists) {
              return Right(DailyReportModel.fromSnapshot(snapshot));
            } else {
              // لو مفيش بيانات النهارده، نرجع تقرير فاضي
              return Right(
                DailyReport(
                  date: DateTime.now(),
                  totalRevenue: 0,
                  orderCount: 0,
                ),
              );
            }
          } catch (e) {
            return Left(ServerFailure("Error parsing daily report: $e"));
          }
        })
        .handleError((error) {
          // هندير الأخطاء اللي بتيجي من stream نفسه
          return Left(ServerFailure("Failed to stream report: $error"));
        });
  }
}

import 'package:coffee_shop_admin_dashboard/domain/entities/report.dart';
import 'package:equatable/equatable.dart';

enum ViewStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final ViewStatus status;
  final DailyReport? report;
  final String? errorMessage;

  final int selectedIndex;

  const DashboardState({
    this.status = ViewStatus.initial,
    this.report,
    this.errorMessage,

    this.selectedIndex = 0,
  });

  DashboardState copyWith({
    ViewStatus? status,
    DailyReport? report,
    String? errorMessage,

    int? selectedIndex,
  }) {
    return DashboardState(
      status: status ?? this.status,
      report: report ?? this.report,
      errorMessage: errorMessage ?? this.errorMessage,

      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [status, report, errorMessage, selectedIndex];
}

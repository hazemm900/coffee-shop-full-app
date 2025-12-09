import 'dart:async';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_daily_report_stream_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/reports_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/dashboard_home_viewmodel/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// 🧩 استورد الصفحات اللي هتظهر في الداشبورد
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/products_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/users/users_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/promotions/promotions_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/send_notification_page.dart';

class DashboardViewModel extends Cubit<DashboardState> {
  final GetDailyReportStreamUsecase getDailyReportStreamUsecase;
  StreamSubscription? _reportSubscription;

  DashboardViewModel(this.getDailyReportStreamUsecase)
    : super(const DashboardState()) {
    _listenToDailyReport();
  }

  // ✅ الصفحات اللي عندك
  final List<Widget> pages = const [
    DashboardPage(),
    ProductsPage(),
    UsersPage(currentUserRole: 'super_admin'),
    PromotionsPage(),
    SendNotificationPage(),
  ];

  // ✅ العناوين الخاصة بكل صفحة
  final List<String> pageTitles = const [
    'Dashboard Overview',
    'Product Management',
    'User Management',
    '🎁 Promotions Management',
    'Send Notifications',
  ];

  void _listenToDailyReport() {
    emit(state.copyWith(status: ViewStatus.loading));
    _reportSubscription = getDailyReportStreamUsecase.execute().listen((
      result,
    ) {
      result.fold(
        (failure) => emit(
          state.copyWith(status: ViewStatus.error, errorMessage: "Error"),
        ),
        (report) =>
            emit(state.copyWith(status: ViewStatus.success, report: report)),
      );
    });
  }

  void changePage(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  @override
  Future<void> close() {
    _reportSubscription?.cancel();
    return super.close();
  }
}

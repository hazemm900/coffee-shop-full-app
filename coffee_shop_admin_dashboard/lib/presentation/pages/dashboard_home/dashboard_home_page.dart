import 'package:coffee_shop_admin_dashboard/core/service_locator.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_daily_report_stream_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/dashboard_home_viewmodel/dashboard_state.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/dashboard_home_viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/side_navigation_bar.dart';
import 'widgets/dashboard_app_bar.dart';
import 'widgets/dashboard_content.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardViewModel(sl<GetDailyReportStreamUsecase>()),
      child: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          final cubit = context.read<DashboardViewModel>();

          return Scaffold(
            backgroundColor: const Color(0xFFFAF6F2),
            body: Row(
              children: [
                /// 🧭 الـ NavigationBar
                SideNavigationBar(
                  selectedIndex: state.selectedIndex,
                  onDestinationSelected: cubit.changePage,
                ),

                /// 📊 الـ Main Content
                Expanded(
                  child: Column(
                    children: [
                      DashboardAppBar(
                            title: cubit.pageTitles[state.selectedIndex],
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideY(begin: -0.2, end: 0),

                      Expanded(
                        child:
                            DashboardContent(
                                  page: cubit.pages[state.selectedIndex],
                                )
                                .animate()
                                .fadeIn(duration: 500.ms)
                                .slideX(begin: 0.1, end: 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

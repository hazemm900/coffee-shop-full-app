import 'package:coffee_shop_app/presentation/view/pages/register/login_page.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/category_tabbar_widget.dart';
// 🧩 Widgets
import 'widgets/home_header_section.dart';
import 'widgets/offers_banner.dart';
import 'widgets/products_grid.dart';
import 'widgets/search_bar_section.dart';
import 'widgets/sliver_appbar_delegate.dart';

/// 🏠 HomePage
/// - Organized modular structure with animations
/// - Clean code & consistent style
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeState>(
      listener: (context, state) {
        // 🧭 Handle logout navigation
        if (state.isLogoutSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      builder: (context, state) {
        // 🌀 Loading state
        if (state.status == HomeStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ Error state
        if (state.status == HomeStatus.error) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.errorMessage ?? 'An error occurred'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<HomeViewModel>().reloadData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // ✅ Success state
        return DefaultTabController(
          length: state.categories.length,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 8),
                            HomeHeaderSection(),
                            SizedBox(height: 12),
                            SearchBarSection(),
                            SizedBox(height: 16),
                            OffersBanner(),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverAppBarDelegate(CategoryTabBarWidget()),
                    ),
                  ];
                },
                body: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ProductsGrid(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

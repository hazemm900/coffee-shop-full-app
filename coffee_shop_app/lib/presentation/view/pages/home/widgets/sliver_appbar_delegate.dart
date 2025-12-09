/* -----------------------------------------------------
   🔧 _SliverAppBarDelegate
   - Keeps TabBar pinned
   - Fixed height to prevent layoutExtent > paintExtent error
   ----------------------------------------------------- */
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _tabBar;

  const SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 56, // ✅ match extents to prevent render overflow
      color: AppColors.backgroundLight,
      alignment: Alignment.center,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) => false;
}

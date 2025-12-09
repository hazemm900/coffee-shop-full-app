import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _revenueController;
  late AnimationController _ordersController;
  late AnimationController _avgController;

  late Animation<double> _revenueAnimation;
  late Animation<double> _ordersAnimation;
  late Animation<double> _avgAnimation;

  late List<double> weeklyRevenue; // بيانات الإيراد الأسبوعي

  @override
  void initState() {
    super.initState();

    // بيانات تجريبية عشوائية
    final random = Random();
    final totalRevenue = random.nextInt(15000) + 3000;
    final orderCount = random.nextInt(120) + 20;
    final avgOrderValue = totalRevenue / orderCount;

    weeklyRevenue = List.generate(7, (_) => random.nextInt(2000) + 500.0);

    // إعداد الـ Animations
    _revenueController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _ordersController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _avgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _revenueAnimation = Tween<double>(begin: 0, end: totalRevenue.toDouble())
        .animate(
          CurvedAnimation(parent: _revenueController, curve: Curves.easeOut),
        );

    _ordersAnimation = Tween<double>(begin: 0, end: orderCount.toDouble())
        .animate(
          CurvedAnimation(parent: _ordersController, curve: Curves.easeOut),
        );

    _avgAnimation = Tween<double>(
      begin: 0,
      end: avgOrderValue.toDouble(),
    ).animate(CurvedAnimation(parent: _avgController, curve: Curves.easeOut));

    // تشغيل الأنيميشن بالتتابع
    _revenueController.forward().then((_) {
      _ordersController.forward().then((_) {
        _avgController.forward();
      });
    });
  }

  @override
  void dispose() {
    _revenueController.dispose();
    _ordersController.dispose();
    _avgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('dd MMMM yyyy').format(DateTime.now());
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            "Today's Summary ($today)",
            style: Theme.of(context).textTheme.headlineSmall,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),

          const SizedBox(height: 16),

          /// ==== الإحصائيات ====
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              AnimatedBuilder(
                animation: _revenueAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: 'Total Revenue',
                    value: '${_revenueAnimation.value.toStringAsFixed(2)} EGP',
                    icon: Icons.monetization_on,
                    color: Colors.green,
                  );
                },
              ).animate().fadeIn().slideX(begin: -0.2),

              AnimatedBuilder(
                animation: _ordersAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: 'Total Orders',
                    value: _ordersAnimation.value.toInt().toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  );
                },
              ).animate().fadeIn().slideX(begin: 0.2),

              AnimatedBuilder(
                animation: _avgAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: 'Avg. Order Value',
                    value: '${_avgAnimation.value.toStringAsFixed(2)} EGP',
                    icon: Icons.functions,
                    color: Colors.orange,
                  );
                },
              ).animate().fadeIn().slideY(begin: 0.3),
            ],
          ),

          const SizedBox(height: 32),

          /// ==== المخطط الأسبوعي ====
          Text(
            "Weekly Revenue Overview",
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn().slideY(begin: 0.3),

          const SizedBox(height: 12),

          AspectRatio(
            aspectRatio: 1.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Sun',
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                        ];
                        return Text(days[value.toInt() % 7]);
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(7, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: weeklyRevenue[index],
                        gradient: LinearGradient(
                          colors: [
                            Colors.brown.shade400,
                            Colors.brown.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),
        ],
      ),
    );
  }
}

/// ===== بطاقة الإحصائيات =====
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 36, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

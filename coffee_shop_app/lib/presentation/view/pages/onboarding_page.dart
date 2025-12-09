import 'package:coffee_shop_app/presentation/view/pages/register/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/service_locator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool _isLastPage = false;

  // دالة لحفظ أن المستخدم قد شاهد الـ Onboarding
  Future<void> _onDone() async {
    final prefs = sl<SharedPreferences>();
    await prefs.setBool('hasSeenOnboarding', true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. الصفحات
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _isLastPage = (index == 2); // لدينا 3 صفحات (0, 1, 2)
              });
            },
            children: const [
              OnboardingScreen(
                imagePath:
                    'assets/images/coffee_onboarding1.png', // تأكد من إضافة الصور
                title: 'Discover Delicious Coffee',
                subtitle:
                    'Explore our wide range of premium coffee beans and drinks, crafted just for you.',
              ),
              OnboardingScreen(
                imagePath: 'assets/images/coffee_onboarding2.jpg',
                title: 'Add to Cart Easily',
                subtitle:
                    'Select your favorite items and add them to your cart with a single tap.',
              ),
              OnboardingScreen(
                imagePath: 'assets/images/coffee_onboarding3.jpg',
                title: 'Earn Loyalty Points',
                subtitle:
                    'Get rewarded for every purchase and redeem your points for amazing discounts.',
              ),
            ],
          ),
          // 2. مؤشر النقاط والأزرار
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر التخطي (Skip)
                TextButton(onPressed: _onDone, child: const Text('SKIP')),
                // مؤشر النقاط
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                ),
                // زر التالي أو البدء
                _isLastPage
                    ? TextButton(onPressed: _onDone, child: const Text('DONE'))
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('NEXT'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget بسيط لعرض كل شاشة ترحيبية
class OnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 300),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

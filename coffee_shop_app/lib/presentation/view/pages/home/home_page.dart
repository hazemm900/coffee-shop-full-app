import 'package:carousel_slider/carousel_slider.dart'; // 1. ضيف المكتبة دي
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart'; // 2. ضيف المكتبة دي

// Import your other widgets...
import 'package:coffee_shop_app/presentation/view/pages/register/login_page.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'widgets/category_tabbar_widget.dart';
import 'widgets/home_header_section.dart';
import 'widgets/products_grid.dart';
import 'widgets/search_bar_section.dart';
import 'widgets/sliver_appbar_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeState>(
      listener: (context, state) {
        if (state.isLogoutSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == HomeStatus.error) {
          return Scaffold(
            body: Center(child: Text(state.errorMessage ?? 'Error')),
          );
        }

        return DefaultTabController(
          length: state.categories.length, // عدد التصنيفات
          child: Scaffold(
            backgroundColor: Colors.white, // خلفية بيضاء لنظافة التصميم
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            // 1️⃣ الجزء الثابت: الاسم والنقاط
                            const HomeHeaderSection(),

                            const SizedBox(height: 16),

                            // 2️⃣ السحر الأول: سلايدر العروض المتحرك
                            const AnimatedOffersCarousel(),

                            const SizedBox(height: 20),

                            // 3️⃣ السحر الثاني: شركاء النجاح (طلبات، وفرها، رابيت)
                            const PartnersSection(),

                            const SizedBox(height: 20),

                            // 4️⃣ السحر الثالث: أزرار التحكم السريعة (القصة - المنيو - سوشيال)
                            const QuickActionsSection(),

                            const SizedBox(height: 20),

                            // 5️⃣ البحث (خليناه هنا عشان يبقى قبل المنيو مباشرة)
                            const SearchBarSection(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),

                    // التاب بار (المنيو) بيفضل لازق فوق لما تعمل سكرول
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

// =================================================================
// 🧩 Widgets الجديدة (خدها حطها في ملفات منفصلة أو تحت الصفحة مؤقتاً)
// =================================================================

/// 🎡 2. Animated Offers Slider (الجزء المتحرك)
class AnimatedOffersCarousel extends StatelessWidget {
  const AnimatedOffersCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة صور وهمية للعروض (غيرها بصور من عندك)
    final List<String> imgList = [
      'https://cdn.create.vista.com/downloads/9686ef11-aa93-4b02-9307-992ade96204e_1024.jpeg',
      'https://cdn.vectorstock.com/i/1000v/97/75/coffee-promotion-flyer-set-vector-29349775.jpg',
      'https://img.pikbest.com/backgrounds/20210623/coffee-shop-promotion-banner_6026970.jpg!sw800',
      'https://www.shutterstock.com/shutterstock/photos/1529690471/display_1500/stock-vector-coffee-discount-set-of-flyer-voucher-with-coffee-beans-pattern-and-cup-with-advertising-promo-1529690471.jpg',
      'https://img.freepik.com/premium-vector/coffee-discount-coupon-voucher-with-torn-off-part-with-coffee-cup-beans-pattern-graphic_348818-1057.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 160.0, // ارتفاع البانر
        autoPlay: true, // يشتغل لوحده
        autoPlayInterval: const Duration(seconds: 3), // كل 3 ثواني يقلب
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true, // الصورة اللي في النص تكبر
        viewportFraction: 0.9, // يظهر حتة من الصورة اللي جنبها
        aspectRatio: 16 / 9,
      ),
      items: imgList
          .map(
            (item) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0), // حواف دائرية شيك
                child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
              ),
            ),
          )
          .toList(),
    );
  }
}

/// 🤝 3. Partners Section (طلبات - وفرها - رابيت)
class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  Future<void> _launchLink(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order From Partners",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 🟡 Talabat
            _buildPartnerCircle(
              'assets/images/talabat_logo.png', // ⚠️ تأكد من الاسم
              "Talabat",
              () {},
            ),

            // 🟢 Waffarha
            _buildPartnerCircle(
              'assets/images/wafarha_logo.png', // ⚠️ تأكد من الاسم
              "Waffarha",
              () => _launchLink("https://ad.waff.me/g9nk8x"),
            ),

            // 🐰 Rabbit
            _buildPartnerCircle(
              'assets/images/rabbit_logo.jpg', // ⚠️ تأكد من الاسم
              "Rabbit",
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPartnerCircle(
    String imagePath,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(imagePath), // ✅ هنا بيسحب الصورة
                fit: BoxFit.cover, // أو BoxFit.contain حسب شكل اللوجو
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// 🔘 4. Quick Actions Buttons (القصة - المنيو - السوشيال)
class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  // دالة لفتح السوشيال ميديا
  Future<void> _launchSocial(String urlString) async {
    final Uri url = Uri.parse(urlString);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // BottomSheet عشان يختار تيك توك ولا انستجرام (بالصور)
  void _showSocialOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 250, // زودنا الطول سنة عشان الصور تاخد راحتها
        child: Column(
          children: [
            const Text(
              "Follow Us On",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زرار انستجرام
                _socialImageBtn(
                  'assets/images/instagram_logo.png', // ⚠️ تأكد من اسم الصورة عندك
                  "Instagram",
                  () {
                    _launchSocial(
                      "https://www.instagram.com/solis__eg?igsh=Nzl0dmhyNXJoNzdy",
                    );
                  },
                ),
                // زرار تيك توك
                _socialImageBtn(
                  'assets/images/tiktok_logo.png', // ⚠️ تأكد من اسم الصورة عندك
                  "TikTok",
                  () {
                    _launchSocial(
                      "https://www.tiktok.com/@solis__eg?_r=1&_t=ZS-92DOPzeJG59",
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget عشان يعرض الصورة بدل الايقونة
  Widget _socialImageBtn(String imagePath, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ), // حاشية عشان اللوجو ميبقاش لازق في الحواف
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Menu
        Expanded(
          child: _buildActionButton(
            context,
            title: "Menu",
            icon: Icons.restaurant_menu,
            color: const Color(0xFFD4A373),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),

        // 2. Our Story
        Expanded(
          child: _buildActionButton(
            context,
            title: "Our Story",
            icon: Icons.history_edu,
            color: Colors.brown.shade300,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),

        // 3. Contact
        Expanded(
          child: _buildActionButton(
            context,
            title: "Contact",
            icon: Icons.chat_bubble_outline,
            color: Colors.grey.shade800,
            onTap: () => _showSocialOptions(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

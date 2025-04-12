import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shrimp_care_mobileapp/features/sampling/views/page/detail_sampling_page.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/page/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';

Widget informationCardSlider() {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> cards = [
    {
      "icon": Icons.sports_cricket_outlined,
      "title": "Cek Kondisi Udang Anda",
      "description":
          "Klik disini untuk bisa memulai diagnosa penyakit udang vanname anda!",
    },
    {
      "icon": Icons.science_outlined,
      "title": "Sampling",
      "description": "Data sampling tambak udang",
    },
  ];

  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        children: [
          SizedBox(
            height: 115,
            child: PageView.builder(
              controller: pageController,
              itemCount: cards.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return informationCard(
                  icon: cards[index]["icon"],
                  title: cards[index]["title"],
                  description: cards[index]["description"],
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagnosisPage(),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailSamplingPage(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: pageController,
            count: cards.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.white,
              dotColor: Colors.grey.shade400,
            ),
          ),
        ],
      );
    },
  );
}

Widget informationCard({
  required IconData icon,
  required String title,
  required String description,
  required VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 115,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColor.softSecondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: MyColor.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: MyTextStyle.text16.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: MyTextStyle.text12,
                  ),
                ),
                Image.asset(
                  'assets/images/core/icon_shrimp_care.png',
                  width: 80,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/home/providers/greeting_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/diagnosis_card.dart';
import 'package:shrimp_care_mobileapp/features/disease/views/widget/disease_card.dart';
import 'package:shrimp_care_mobileapp/features/home/views/widget/information_card.dart';
import 'package:shrimp_care_mobileapp/features/home/views/widget/menu.dart';
import 'package:shrimp_care_mobileapp/features/home/views/widget/text_top_card.dart';

class HomePage extends StatelessWidget {
  final bool isSamplingDataEmpty;

  const HomePage({super.key, this.isSamplingDataEmpty = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: isSamplingDataEmpty ? 285 : 290,
                  color: MyColor.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<GreetingProvider>(
                                  builder: (context, greetingProvider, _) {
                                    return Text(
                                      greetingProvider.getGreeting(),
                                      style: MyTextStyle.text18.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    );
                                  },
                                ),
                                Consumer<GreetingProvider>(
                                  builder: (context, greetingProvider, _) {
                                    return FutureBuilder<String?>(
                                      future: greetingProvider.nameGreeting(),
                                      builder: (context, snapshot) {
                                        if (greetingProvider.isLoading) {
                                          return const CircularProgressIndicator(
                                            color: Colors.white,
                                          );
                                        }
                                        return Text(
                                          snapshot.data ?? '',
                                          style: MyTextStyle.text18.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        informationCardSlider(),
                      ],
                    ),
                  ),
                ),
                if (isSamplingDataEmpty)
                  GestureDetector(
                    onTap: () {
                      // todo: navigate to sampling page
                    },
                    child: Container(
                      height: 50,
                      color: MyColor.primary,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0F39B3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mail, color: Colors.white),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Kamu belum mengisi data harian sampling.",
                                    style: MyTextStyle.text12
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                Container(
                  height: 20,
                  color: isSamplingDataEmpty
                      ? const Color(0xFF0F39B3)
                      : MyColor.primary,
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: MyColor.themeColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(14),
                          child: menu(context)),
                      const SizedBox(height: 16),
                      textTopCard(
                        title: "Waspadai Penyakit Udang",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      diseaseCard(
                          image:
                              "https://cdn-icons-png.flaticon.com/512/1040/1040204.png",
                          title: "Bintik Putih (White Spot Disease)",
                          description:
                              "Penyakit akibat virus yang menyebabkan bercak putih pada badan udang dan mantap  ",
                          risk: 5,
                          onTap: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                      textTopCard(
                        title: "Riwayat Diagnosis",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      diagnosisCard(
                          title: "Bintik Putih (White Spot Disease)",
                          image:
                              "https://cdn-icons-png.flaticon.com/512/1040/1040204.png",
                          accuracy: 50,
                          date: "22 Maret 2025",
                          onTap: () {}),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

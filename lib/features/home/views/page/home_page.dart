import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/disease_provider.dart';
import 'package:shrimp_care_mobileapp/features/home/providers/greeting_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/diagnosis_card.dart';
import 'package:shrimp_care_mobileapp/features/disease/views/widget/disease_card.dart';
import 'package:shrimp_care_mobileapp/features/home/views/widget/information_card.dart';
import 'package:shrimp_care_mobileapp/features/home/views/widget/menu.dart';
import 'package:shrimp_care_mobileapp/features/home/views/widget/text_top_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  final bool isSamplingDataEmpty;

  const HomePage({super.key, this.isSamplingDataEmpty = true});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<DiseaseProvider>().fetchDiseases();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: widget.isSamplingDataEmpty ? 285 : 290,
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
                if (widget.isSamplingDataEmpty)
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
                  color: widget.isSamplingDataEmpty
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
                      Consumer<DiseaseProvider>(
                          builder: (context, diseaseProvider, child) {
                        if (diseaseProvider.diseases.isNotEmpty) {
                          return Skeletonizer(
                            enabled: diseaseProvider.isLoading,
                            enableSwitchAnimation: true,
                            child: Column(
                              children: List.generate(
                                diseaseProvider.diseases.length,
                                (index) {
                                  final disease =
                                      diseaseProvider.diseases[index];
                                  return Column(
                                    children: [
                                      diseaseCard(
                                        title: disease.nameDisease!,
                                        // image: disease.imageDisease!,
                                        image:
                                            "https://strapi.jala.tech/uploads/contoh_udang_yang_terkena_penyakit_black_spot_disease_41098d2b90.jpg",
                                        risk: disease.riskLevel!,
                                        description:
                                            disease.descriptionDisease!,
                                        onTap: () {
                                          context.pushNamed(
                                            'detail_disease',
                                            pathParameters: {
                                              'id': disease.id!,
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return nullState(nullTitle: "Belum ada data!");
                        }
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      textTopCard(
                        title: "Riwayat Diagnosis",
                        onTap: () {
                          context.pushNamed("riwayat_diagnosis");
                        },
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

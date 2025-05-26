import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosa_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosis_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/disease_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/diseases_provider.dart';
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
    Future.microtask(() {
      Provider.of<DiseasesProvider>(context, listen: false)
          .getHighRiskDisease();
      Provider.of<DiagnosisProvider>(context, listen: false).fetchDiagnosis(
        setLimit: 2,
        startDate: null,
        endDate: null,
      );
    });
  }

  Widget build(BuildContext context) {
    final diseaseProvider = Provider.of<DiseasesProvider>(context);
    final disease = diseaseProvider.highRiskDisease;

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
                        onTap: () {
                          context.pushNamed('disease').then((_) {
                            context
                                .read<DiseaseProvider>()
                                .fetchDiseaseHomePage();
                            context.read<DiseaseProvider>().resetParams();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: disease.isEmpty
                            ? [nullState(nullTitle: "Belum ada data!")]
                            : List.generate(
                                2,
                                (index) {
                                  final data = disease[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: diseaseCard(
                                      title: data.nameDisease!,
                                      image: data.imageDisease!,
                                      risk: data.riskLevel!,
                                      description: data.definitionDisease!,
                                      onTap: () {
                                        if (data.id != null) {
                                          context.pushNamed(
                                            'detail_disease',
                                            pathParameters: {
                                              'id': data.id!,
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
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
                      Consumer<DiagnosisProvider>(
                        builder: (context, diagnosisProvider, child) =>
                            diagnosisProvider.isLoading
                                ? Column(
                                    children: List.generate(2, (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Skeletonizer(
                                          enableSwitchAnimation: true,
                                          enabled: true,
                                          child: diagnosisCard(
                                            image: "-",
                                            title: "------------------",
                                            accuracy: 0,
                                            onTap: () {},
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                : (diagnosisProvider.diagnosis.isEmpty)
                                    ? nullState(nullTitle: "Belum ada data!")
                                    : Column(
                                        children: List.generate(
                                          diagnosisProvider.diagnosis.length,
                                          (index) {
                                            final disease = diagnosisProvider
                                                .diagnosis[index];
                                            return Column(
                                              children: [
                                                diagnosisCard(
                                                    title: disease.nameDisease!,
                                                    image:
                                                        disease.imageDisease!,
                                                    accuracy: double.parse(disease
                                                        .bestPercentageDisease!),
                                                    date: disease.createdAt!,
                                                    onTap: () {
                                                      context.pushNamed(
                                                        'detail_diagnosis',
                                                        pathParameters: {
                                                          'id': disease.id!,
                                                        },
                                                      );
                                                    }),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                      ),
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

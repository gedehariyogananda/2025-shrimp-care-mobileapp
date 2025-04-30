import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosis_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/disease_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/attention_card.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/diagnosis_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ResultDiagnosisPage extends StatefulWidget {
  final String id;

  const ResultDiagnosisPage({super.key, required this.id});

  @override
  State<ResultDiagnosisPage> createState() => _ResultDiagnosisPageState();
}

class _ResultDiagnosisPageState extends State<ResultDiagnosisPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DiagnosisProvider>().fetchResultDiagnosis(
            diagnosisId: widget.id,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        onLeadingPressed: () {
          Future.microtask(() {
            Provider.of<DiseaseProvider>(context, listen: false)
                .fetchDiseaseHomePage();
            Provider.of<DiagnosisProvider>(context, listen: false)
                .fetchDiagnosis(
              setLimit: 2,
              startDate: null,
              endDate: null,
            );
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        title: "Hasil Diagnosis Ditemukan!",
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kondisi Yang Memungkinakan",
              style: MyTextStyle.text18.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Berikut hasil penyakit yang paling sesuai dengan kondisi udangmu. Pilih yang paling cocok untuk mengetahui lebih lanjut!",
              style: MyTextStyle.text14.copyWith(color: MyColor.secondary),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<DiagnosisProvider>(
                  builder: (context, diagnosisProvider, child) =>
                      diagnosisProvider.isLoading
                          ? Column(
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Skeletonizer(
                                    enableSwitchAnimation: true,
                                    enabled: true,
                                    child: diagnosisCard(
                                      title: "-----------",
                                      image: "-",
                                      accuracy: 0,
                                      onTap: () {},
                                    ),
                                  ),
                                );
                              }),
                            )
                          : (diagnosisProvider.resultDiagnosis.isEmpty
                              ? nullState(nullTitle: "Belum ada data!")
                              : Column(
                                  children: List.generate(
                                    diagnosisProvider.resultDiagnosis.length,
                                    (index) {
                                      final resultDiagnosis = diagnosisProvider
                                          .resultDiagnosis[index];
                                      return Column(
                                        children: [
                                          diagnosisCard(
                                            title: resultDiagnosis.nameDisease!,
                                            image: resultDiagnosis.imageDisease!,
                                            // image:
                                            //     "https://cdn-icons-png.flaticon.com/512/1040/1040204.png",
                                            accuracy: double.parse(
                                                resultDiagnosis.percentage!),
                                            onTap: () {
                                              context.pushNamed(
                                                'detail_disease',
                                                pathParameters: {
                                                  'id': resultDiagnosis
                                                      .diseaseId!,
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )),
                ),
              ),
            ),
            SizedBox(height: 16),
            attentionCard(
                isAlertDanger: false,
                icon: Icons.query_stats_outlined,
                title: "Tidak menemukan hasil yang tepat?",
                description: "Klik untuk melakukan diagnosa ulang.",
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}

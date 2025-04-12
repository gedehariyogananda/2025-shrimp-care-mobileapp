import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosis_provider.dart';
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
      appBar: CustomAppBar(title: "Hasil Diagnosis Ditemukan!"),
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
            SizedBox(height: 24),
            Consumer<DiagnosisProvider>(
                builder: (context, diagnosisProvider, child) {
              if (diagnosisProvider.resultDiagnosis.isNotEmpty) {
                return Skeletonizer(
                  enabled: diagnosisProvider.isLoading,
                  enableSwitchAnimation: true,
                  child: Column(
                    children: List.generate(
                      diagnosisProvider.resultDiagnosis.length,
                      (index) {
                        final resultDiagnosis =
                            diagnosisProvider.resultDiagnosis[index];
                        return Column(
                          children: [
                            diagnosisCard(
                              title: resultDiagnosis.nameDisease!,
                              // image: disease.imageDisease!,
                              image:
                                  "https://cdn-icons-png.flaticon.com/512/1040/1040204.png",
                              accuracy:
                                  double.parse(resultDiagnosis.percentage!),
                              onTap: () {
                                context.pushNamed(
                                  'detail_disease',
                                  pathParameters: {
                                    'id': resultDiagnosis.diseaseId!,
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

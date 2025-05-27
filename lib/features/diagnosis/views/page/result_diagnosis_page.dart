import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosa_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosis_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/diseases_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/disease.dart';
import 'package:shrimp_care_mobileapp/utils/disease_helper.dart';
import 'package:shrimp_care_mobileapp/utils/format_helper.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/attention_card.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/diagnosis_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ResultDiagnosisPage extends StatefulWidget {
  final int id;

  const ResultDiagnosisPage({super.key, required this.id});

  @override
  State<ResultDiagnosisPage> createState() => _ResultDiagnosisPageState();
}

class _ResultDiagnosisPageState extends State<ResultDiagnosisPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DiagnosaProvider>().fetchDiagnoses(diagnosisId: widget.id);
      context.read<DiagnosaProvider>().getDiagnosisById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final diagnosisProvider = Provider.of<DiagnosaProvider>(context);
    final dataDiagnosis = diagnosisProvider.diagnosis;

    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        onLeadingPressed: () {
          Future.microtask(() {
            Provider.of<DiseasesProvider>(context, listen: false)
                .getHighRiskDisease();
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
            Text.rich(
              TextSpan(
                text:
                    'Berdasarkan gejala yang kamu pilih, sistem memberikan kesimpulan bahwa udangmu ',
                style: MyTextStyle.text14.copyWith(color: MyColor.secondary),
                children: [
                  TextSpan(
                    text: '${dataDiagnosis?.explain}',
                    style: MyTextStyle.text14.copyWith(
                      fontWeight: FontWeight.bold,
                      color:  MyDisease.getColorByAccuracy(
                        dataDiagnosis?.percentage ?? 0,
                      ),
                    ),
                  ),
                  TextSpan(
                    text:
                        ' terdampak penyakit di bawah ini dengan persentase akurasi sistem tertinggi yaitu ',
                  ),
                  TextSpan(
                    text: formatPercentage(
                        dataDiagnosis?.percentage ?? 0) + ' %',
                    style: MyTextStyle.text14.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyDisease.getColorByAccuracy(
                        dataDiagnosis?.percentage ?? 0,
                      ),
                    ),
                  ),
                  TextSpan(text: '. Kamu dapat melihat detail gejala keseluruhan dan penanganan dengan klik pada penyakit yang terdiagnosa.'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Consumer<DiagnosaProvider>(
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
                            : (diagnosisProvider.diagnoses.isEmpty
                                ? nullState(nullTitle: "Belum ada data!")
                                : Column(
                                    children: List.generate(
                                      diagnosisProvider.diagnoses.length,
                                      (index) {
                                        final diagnoses =
                                            diagnosisProvider.diagnoses[index];

                                        final diseaseInfo =
                                            getDiseaseById(diagnoses.diseaseId);
                                        return Column(
                                          children: [
                                            diagnosisCard(
                                              title: diseaseInfo?.nameDisease ??
                                                  '',
                                              image:
                                                  diseaseInfo?.imageDisease ??
                                                      '',
                                              accuracy: diagnoses.percentage,
                                              onTap: () {
                                                context.pushNamed(
                                                  'detail_disease',
                                                  pathParameters: {
                                                    'id': diagnoses.diseaseId,
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
                  SizedBox(height: 16),
                  attentionCard(
                      isAlertDanger: true,
                      icon: Icons.warning_amber_outlined,
                      title: "Perhatian!",
                      description: "Hasil ini berdasarkan sistem pakar dan dari gejala yang kamu pilih. Untuk kepastian diagnosis dan pengobatan, silakan konsultasikan ke ahli/teknisi/medis.",
                      onTap: null),
                ],
              )),
            ),
            // SizedBox(height: 16),
            // attentionCard(
            //     isAlertDanger: false,
            //     icon: Icons.query_stats_outlined,
            //     title: "Tidak menemukan hasil yang tepat?",
            //     description: "Klik untuk melakukan diagnosa ulang.",
            //     onTap: () {}),
          ],
        ),
      ),
    );
  }
}

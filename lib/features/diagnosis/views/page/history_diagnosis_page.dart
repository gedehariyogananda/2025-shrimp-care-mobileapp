import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosis_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/page/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/diagnosis_card.dart';
import 'package:shrimp_care_mobileapp/utils/alert_flushbar.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryDiagnosisPage extends StatefulWidget {
  @override
  _HistoryDiagnosisPageState createState() => _HistoryDiagnosisPageState();
}

class _HistoryDiagnosisPageState extends State<HistoryDiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    final diagnosisProvider = Provider.of<DiagnosisProvider>(context);
    final selectedDate = diagnosisProvider.selectedDate;

    return Scaffold(
      appBar: CustomAppBar(
        title: "History Diagnosis",
      ),
      backgroundColor: MyColor.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "Riwayat Diagnosis",
                      style: MyTextStyle.text16.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: MyColor.softSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_new,
                                size: 15, color: MyColor.secondary),
                            onPressed: () => diagnosisProvider
                                .changeMonth(-1, context, onError: (error) {
                              AlertSnackbar.showErrorSnackbar(
                                context,
                                error.toString(),
                              );
                            }),
                          ),
                          Text(
                            DateFormat(AppConstants.formatHistoryDiagnosa,
                                    AppConstants.initializedLang)
                                .format(selectedDate),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                size: 15, color: MyColor.secondary),
                            onPressed: () => diagnosisProvider
                                .changeMonth(1, context, onError: (error) {
                              AlertSnackbar.showErrorSnackbar(
                                context,
                                error.toString(),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 16),
            Consumer<DiagnosisProvider>(
                builder: (context, diagnosisProvider, child) {
              if (diagnosisProvider.diagnosis.isNotEmpty) {
                return Skeletonizer(
                  enabled: diagnosisProvider.isLoading,
                  enableSwitchAnimation: true,
                  child: Column(
                    children: List.generate(
                      diagnosisProvider.diagnosis.length,
                      (index) {
                        final disease = diagnosisProvider.diagnosis[index];
                        return Column(
                          children: [
                            diagnosisCard(
                                title: disease.nameDisease!,
                                // image: disease.imageDisease!,
                                image:
                                    "https://cdn-icons-png.flaticon.com/512/1040/1040204.png",
                                accuracy: double.parse(
                                    disease.bestPercentageDisease!),
                                date: disease.createdAt!,
                                onTap: () {}),
                          ],
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: nullState(
                      nullTitle: "Belum Ada Riwayat Diagnosis Bulan Ini",
                      description:
                          "Mulai diagnosis untuk mengetahui kondisi udangmu.",
                      buttonTitle: "Cek Diagnosis",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiagnosisPage()),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

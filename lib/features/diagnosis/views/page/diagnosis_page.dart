import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosa_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/disease.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/diseases_provider.dart';
import 'package:shrimp_care_mobileapp/utils/alert_flushbar.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/utils/loading_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  bool isCheckboxMode = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DiagnosaProvider>(context, listen: false).getAllSymptoms();
    });
  }

  @override
  void dispose() {
    Provider.of<DiagnosaProvider>(context, listen: false).resetSymptoms();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagnosaProvider>(builder: (context, diagnosaProvider, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "Diagnosis Gejala",
          leading: true,
          onLeadingPressed: () {
            Future.microtask(() {
              Provider.of<DiseasesProvider>(context, listen: false)
                  .getHighRiskDisease();
              Provider.of<DiagnosaProvider>(context, listen: false)
                  .fetchDiagnosisHistory();
              diagnosaProvider.resetSymptoms();
            });
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Expanded(
                  child: _buildGejalaSection(
                diagnosaProvider: diagnosaProvider,
              )),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (diagnosaProvider.selectedSymptomCodes.isEmpty) {
                          AlertSnackbar.showErrorSnackbar(
                              context, "Silahkan pilih gejala udangmu!");
                          return;
                        }

                        await loadingScreen(
                          context,
                          title: "Kami sedang bekerja!",
                          description:
                              "Mohon tunggu sebentar, sistem kami sedang mencari hasil terbaik untuk kamu.  🚀",
                        );

                        final diagnosisId = await diagnosaProvider.setDiagnosis(
                          onError: (error) {
                            Navigator.pop(context);
                            context.pushNamed(
                              'result_nan_diagnosis',
                              extra: error.toString(),
                            );
                          },
                        );

                        if (diagnosisId != null) {
                          Navigator.pop(context);
                          context.pushNamed(
                            'detail_diagnosis',
                            pathParameters: {
                              'id': diagnosisId.toString(),
                            },
                          );
                        }
                      },
                      child: Text(
                        "Kirim",
                        style: MyTextStyle.text16.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildGejalaSection({
    DiagnosaProvider? diagnosaProvider,
  }) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Center(
          child: Column(
            children: [
              Text(
                "Detail Gejala Udang",
                style: MyTextStyle.text18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Pilih gejala yang sesuai dengan udangmu.",
                style: MyTextStyle.text14.copyWith(color: MyColor.secondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            // Input Search Field
            Expanded(
              child: TextField(
                onChanged: (value) {
                  diagnosaProvider?.setSearchSymtomps(value);
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Cari gejala...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: MyColor.primary),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8), // Jarak antara TextField dan IconButton

            // Mode Toggle Button
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.checklist_rounded,
                  color:
                      isCheckboxMode ? MyColor.primary : Colors.grey.shade400,
                ),
                onPressed: () {
                  setState(() {
                    isCheckboxMode = !isCheckboxMode;
                  });
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SingleChildScrollView(
              child: _symptompsGrid(
                isCheckboxMode: isCheckboxMode,
                symptoms: diagnosaProvider?.symptoms ?? [],
                selectedSymptomCodes:
                    diagnosaProvider?.selectedSymptomCodes ?? [],
                onSelect: (symptomCode) {
                  diagnosaProvider?.toggleSymptomCode(symptomCode);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _symptompsGrid({
  required List<Symptoms?> symptoms,
  required List<String> selectedSymptomCodes,
  required Function(String) onSelect,
  required bool isCheckboxMode,
}) {
  if (isCheckboxMode) {
    return Column(
      children: symptoms.map((symptom) {
        final isSelected = selectedSymptomCodes.contains(symptom?.id ?? "");

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? MyColor.primary : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: CheckboxListTile(
            title: Text(
              symptom?.nameSymptoms ?? "",
              style: const TextStyle(fontSize: 14),
            ),
            value: isSelected,
            onChanged: (_) => onSelect(symptom?.id ?? ""),
            activeColor: MyColor.primary,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            dense: true,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          ),
        );
      }).toList(),
    );
  }

  // Default (Circle Button Mode)
  return Wrap(
    alignment: WrapAlignment.center,
    spacing: 8.0,
    runSpacing: 8.0,
    children: symptoms.map((symptom) {
      final isSelected = selectedSymptomCodes.contains(symptom?.id ?? "");

      return GestureDetector(
        onTap: () => onSelect(symptom?.id ?? ""),
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected ? MyColor.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? MyColor.primary : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Text(
              symptom?.nameSymptoms ?? "",
              style: MyTextStyle.text14.copyWith(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }).toList(),
  );
}

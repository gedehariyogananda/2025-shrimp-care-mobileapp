import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/fc_diagnosis_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/disease.dart';
import 'package:shrimp_care_mobileapp/utils/alert_flushbar.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/widget/attention_card.dart';
import 'package:shrimp_care_mobileapp/utils/loading_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  bool isGejalaSelected = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FcDiagnosisProvider>(context, listen: false).fetchSymtomps();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FcDiagnosisProvider>(
        builder: (context, fcDiagnosisProvider, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: "Diagnosis Gejala"),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildToggleButton("Gejala", isGejalaSelected,
                      fcDiagnosisProvider.selectedSymptomCodes.isNotEmpty, () {
                    setState(() {
                      isGejalaSelected = true;
                    });
                  }),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 3,
                      color: MyColor.primary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  _buildToggleButton("Threshold", !isGejalaSelected, false, () {
                    setState(() {
                      isGejalaSelected = false;
                    });
                  }),
                ],
              ),
              Expanded(
                child: isGejalaSelected
                    ? _buildGejalaSection(
                        fcDiagnosisProvider: fcDiagnosisProvider,
                      )
                    : _buildThresholdSection(
                        fcDiagnosisProvider: fcDiagnosisProvider,
                      ),
              ),
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
                        if (fcDiagnosisProvider.selectedSymptomCodes.isEmpty) {
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

                        final diagnosisId =
                            await fcDiagnosisProvider.forwardChaining(
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

  Widget _buildToggleButton(String title, bool isSelected,
      bool hasSelectSymtoms, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isSelected
                  ? MyColor.primary
                  : (hasSelectSymtoms ? MyColor.primary : Colors.white),
              border: Border.all(
                color: isSelected ? MyColor.softPrimary : MyColor.secondary,
                width: 2,
              ),
            ),
            child: Icon(
              isSelected &&
                      (title == "Gejala" && hasSelectSymtoms ||
                          title == "Threshold")
                  ? Icons.check
                  : (hasSelectSymtoms ? Icons.check : Icons.circle_outlined),
              color: isSelected || hasSelectSymtoms
                  ? Colors.white
                  : MyColor.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: MyTextStyle.text12,
          ),
        ],
      ),
    );
  }

  Widget _buildGejalaSection({
    FcDiagnosisProvider? fcDiagnosisProvider,
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
        TextField(
          onChanged: (value) {
            fcDiagnosisProvider?.setSearchSymtomps(value);
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _symptompsGrid(
              isLoading: fcDiagnosisProvider?.isLoading ?? false,
              symptoms: fcDiagnosisProvider?.allSymptoms ?? [],
              selectedSymptomCodes:
                  fcDiagnosisProvider?.selectedSymptomCodes ?? [],
              onSelect: (symptomCode) {
                fcDiagnosisProvider?.toggleSymptomCode(symptomCode);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThresholdSection({
    FcDiagnosisProvider? fcDiagnosisProvider,
  }) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Center(
          child: Column(
            children: [
              Text(
                "Tingkat Keyakinan Diagnosis",
                style: MyTextStyle.text18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Atur seberapa yakin sistem dalam menentukan penyakit udangmu.",
                textAlign: TextAlign.center,
                style: MyTextStyle.text14.copyWith(color: MyColor.secondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if ((fcDiagnosisProvider?.threshold ?? 0) > 0) {
                  fcDiagnosisProvider?.setThreshold(
                      (fcDiagnosisProvider?.threshold ?? 0) - 10);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColor.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "${fcDiagnosisProvider?.threshold ?? 0}%",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                if ((fcDiagnosisProvider?.threshold ?? 0) < 100) {
                  fcDiagnosisProvider?.setThreshold(
                      (fcDiagnosisProvider?.threshold ?? 0) + 10);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColor.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        attentionCard(
          isAlertDanger: true,
          icon: Icons.lightbulb,
          description:
              "Jika ingin diagnosis lebih akurat, pilih angka persentase yang lebih tinggi.",
        )
      ],
    );
  }
}

Widget _symptompsGrid({
  required bool isLoading,
  required List<Symptoms?> symptoms,
  required List<String> selectedSymptomCodes,
  required Function(String) onSelect,
}) {
  if (isLoading) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(20, (index) {
        return IntrinsicWidth(
          child: Skeletonizer(
            enabled: true,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: const Text("................"),
            ),
          ),
        );
      }),
    );
  }

  return SingleChildScrollView(
    child: Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: symptoms.map((symptom) {
        final isSelected = selectedSymptomCodes.contains(symptom?.codeSymptoms);
        return GestureDetector(
          onTap: () => onSelect(symptom?.codeSymptoms ?? ""),
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
    ),
  );
}

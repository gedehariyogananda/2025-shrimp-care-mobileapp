import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosa_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/page/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/diseases_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class ResultNanDiagnosisPage extends StatefulWidget {
  final String? messageError;

  const ResultNanDiagnosisPage({super.key, this.messageError});

  @override
  State<ResultNanDiagnosisPage> createState() => _ResultNanDiagnosisPageState();
}

class _ResultNanDiagnosisPageState extends State<ResultNanDiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        onLeadingPressed: () {
          Future.microtask(() {
            Provider.of<DiseasesProvider>(context, listen: false)
                .getHighRiskDisease();
            Provider.of<DiagnosaProvider>(context, listen: false)
                .fetchDiagnosisHistory();
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        title: "Hasil Tidak Ditemukan!",
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.messageError ?? "Diagnosis tidak ditemukan",
              style: MyTextStyle.text18.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Kesimpulan yang dapat diambil adalah tidak ada penyakit yang bisa dideteksi sistem karena ${widget.messageError}!, silahkan coba lagi dengan memilih gejala yang lain.",
              style: MyTextStyle.text14.copyWith(color: MyColor.secondary),
            ),
            SizedBox(height: 120),
            nullState(
              nullTitle: "Data tidak ditemukan",
              description: widget.messageError ?? "Diagnosis tidak ditemukan",
              buttonTitle: "Coba Ulang Diagnosa!",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiagnosisPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

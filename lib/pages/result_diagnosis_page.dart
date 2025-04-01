import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/pages/detail_disease_page.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/widgets/app_bar.dart';
import 'package:shrimp_care_mobileapp/widgets/diagnosis_page/attention_card.dart';
import 'package:shrimp_care_mobileapp/widgets/diagnosis_page/diagnosis_card.dart';
import 'package:shrimp_care_mobileapp/widgets/null_state.dart';

class ResultDiagnosisPage extends StatelessWidget {
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
            diagnosisCard(
                image:
                    "https://strapi.jala.tech/uploads/contoh_udang_yang_terkena_penyakit_black_spot_disease_41098d2b90.jpg",
                title: "Bintik Hitam",
                accuracy: 50,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailDiagnosisPage()),
                  );
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

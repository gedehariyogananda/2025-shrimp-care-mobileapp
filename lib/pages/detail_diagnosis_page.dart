import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/widgets/app_bar.dart';

class DetailDiagnosisPage extends StatelessWidget {
  const DetailDiagnosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detail Diagnosis",
      ),
      body: Container(
        height: 300,
        color: Colors.white,
        width: double.infinity,
        child: Column(
          children: [
            Image.network(
              "https://strapi.jala.tech/uploads/contoh_udang_yang_terkena_penyakit_black_spot_disease_41098d2b90.jpg",
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Text(
              "Bintik Putih (White Spot Disease)",
              style: MyTextStyle.text18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
          ],
        ),
      ),
    );
  }
}

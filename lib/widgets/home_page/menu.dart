import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/pages/detail_sampling_page.dart';
import 'package:shrimp_care_mobileapp/pages/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/pages/disease_page.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';

Widget menu(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      menuItem(
        gradient: [const Color(0xff33A09D), const Color(0xff25706D)],
        icon: Icons.medical_services_rounded,
        outsideColor: MyColor.softSuccess,
        title: 'Penyakit',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiseasePage()),
          );
        },
      ),
      menuItem(
        gradient: [const Color(0xff167CF8), const Color(0xff024EAB)],
        icon: Icons.note_add_sharp,
        outsideColor: MyColor.softPrimary,
        title: 'Diagnosis',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiagnosisPage()),
          );
        },
      ),
      menuItem(
        gradient: [const Color(0xffFFC94D), const Color(0xffFFAA00)],
        icon: Icons.science_outlined,
        outsideColor: MyColor.softWarning,
        title: 'Sampling',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailSamplingPage()),
          );
        },
      ),
    ],
  );
}

Widget menuItem({
  required List<Color> gradient,
  required IconData icon,
  required Color outsideColor,
  required String title,
  required VoidCallback onPressed,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 88,
          height: 78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: outsideColor,
          ),
          child: Column(
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}

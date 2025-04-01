import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrimp_care_mobileapp/constant/const.dart';
import 'package:shrimp_care_mobileapp/pages/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/widgets/alert_snackbar.dart';
import 'package:shrimp_care_mobileapp/widgets/null_state.dart';

class DiagnosaPage extends StatefulWidget {
  @override
  _DiagnosaPageState createState() => _DiagnosaPageState();
}

class _DiagnosaPageState extends State<DiagnosaPage> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void _changeMonth(int increment) {
    setState(() {
      DateTime newDate = DateTime(
        selectedDate.year,
        selectedDate.month + increment,
      );

      if (newDate.isAfter(DateTime.now())) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AlertSnackbar.showErrorSnackbar(
              context, "Tidak bisa memilih bulan di masa depan!");
        });
        return;
      } else {
        selectedDate = newDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed: () => _changeMonth(-1),
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
                            onPressed: () => _changeMonth(1),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: nullState(
                  nullTitle: "Belum Ada Riwayat Diagnosis",
                  description:
                      "Mulai diagnosis untuk mengetahui kondisi udangmu.",
                  buttonTitle: "Cek Diagnosis",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DiagnosisPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

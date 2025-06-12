import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/register_provider.dart';
import 'package:shrimp_care_mobileapp/features/auth/views/widget/form_dropdown.dart';
import 'package:shrimp_care_mobileapp/utils/alert_flushbar.dart';
import 'package:shrimp_care_mobileapp/utils/button.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/text_form_field.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String jobController = '';

  List<String> jobValue = [];

  @override
  void initState() {
    super.initState();

    jobValue = [
      'Pegawai Swasta',
      'Dosen',
      'Penyuluh',
      'Pelajar/Mahasiswa',
      'Peneliti',
      'Sales',
      'Petambak',
      'Lainnya'
    ];
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    jobController = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                color: MyColor.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: MyColor.primary,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Data Diri',
                      style: MyTextStyle.text24.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Masukkan data diri untuk menikmati keseluruhan fitur Shrimp Care.',
                      style: MyTextStyle.text14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 30,
              color: MyColor.primary,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customFormInput(
                      title: 'Nama',
                      hintText: "Masukkan nama",
                      icon: Icons.person,
                      controller: nameController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  formDropdown(
                      title: 'Pekerjaan',
                      isRequired: true,
                      items: jobValue,
                      hintText: 'Pilih pekerjaan',
                      leadingIcon: Icons.work,
                      selectedValue: jobController == '' ? null : jobController,
                      onChanged: (value) {
                        setState(() {
                          jobController = value!;
                        });
                      }),
                  const SizedBox(height: 20),
                  customFormInput(
                      title: 'Umur',
                      hintText: "Masukkan umur",
                      controller: ageController,
                      icon: Icons.accessibility_new_sharp,
                      isRequired: true,
                      forPhoneNumber: true),
                  const SizedBox(height: 20),
                  myButton(
                      text: 'Simpan',
                      isLoading: context.watch<RegisterProvider>().isLoading,
                      onPressed: () {
                        final name = nameController.text.trim();
                        final job = jobController;
                        final age = ageController.text.trim();

                        context.read<RegisterProvider>().register(
                              name: name,
                              job: job,
                              age: age,
                              onError: (error) {
                                AlertSnackbar.showErrorSnackbar(
                                    context, error.toString());
                              },
                              onSuccess: () async {
                                AlertSnackbar.showSuccessSnackbar(
                                    context, 'Data diri berhasil!');
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                context.go('/home_page');
                              },
                            );
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

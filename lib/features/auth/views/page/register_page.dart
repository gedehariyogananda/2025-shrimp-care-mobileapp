import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shrimp_care_mobileapp/features/auth/views/widget/button_oauth.dart';
import 'package:shrimp_care_mobileapp/features/auth/views/widget/form_dropdown.dart';
import 'package:shrimp_care_mobileapp/features/auth/views/widget/separation_line.dart';
import 'package:shrimp_care_mobileapp/utils/button.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/text_form_field.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
      'Lainnya'
    ];
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
                      'Daftar',
                      style: MyTextStyle.text24.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Masuk ke akun untuk menikmati keseluruhan fitur Shrimp Care.',
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
                  customFormInput(
                      title: 'Email',
                      hintText: "Masukkan email",
                      icon: Icons.alternate_email_sharp,
                      controller: emailController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  customFormInput(
                      title: 'Nomor Telepon',
                      hintText: "Masukkan nomor telepon",
                      controller: phoneController,
                      icon: Icons.phone,
                      isRequired: true,
                      forPhoneNumber: true),
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
                      title: 'Kata Sandi',
                      hintText: "Masukkan kata sandi",
                      icon: Icons.lock,
                      controller: passwordController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  customFormInput(
                      title: 'Konfirmasi Kata Sandi',
                      hintText: "Masukkan konfirmasi kata sandi",
                      controller: passwordController,
                      icon: Icons.lock,
                      isRequired: true),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        context.goNamed('login');
                      },
                      child: Text(
                        'Sudah punya akun? Masuk',
                        style: MyTextStyle.text14.copyWith(
                          color: MyColor.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  myButton(text: 'Register', onPressed: () {}),
                  const SizedBox(height: 20),
                  separationLine(),
                  const SizedBox(height: 20),
                  buttonOauth(
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

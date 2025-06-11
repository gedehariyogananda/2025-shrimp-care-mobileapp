import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shrimp_care_mobileapp/features/_auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class AccountPage extends StatelessWidget {
  final Map<String, String> avatarMap = {
    'pegawai swasta': 'assets/avatar/employee.png',
    'dosen': 'assets/avatar/lecturer.png',
    'penyuluh': 'assets/avatar/consultant.png',
    'pelajar/mahasiswa': 'assets/avatar/student.png',
    'peneliti': 'assets/avatar/researcher.png',
    'sales': 'assets/avatar/sales.png',
    'petambak': 'assets/avatar/shrimp_farmer.png',
  };

  @override
  Widget build(BuildContext context) {
    final tokenProvider = context.watch<TokenProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tokenProvider.getName();
      tokenProvider.getAge();
      tokenProvider.getJob();
    });

    final name = tokenProvider.name ?? "-";
    final age = tokenProvider.age ?? "-";
    final job = tokenProvider.job ?? "-";

    final avatarAsset = _getAvatarAsset(job);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(avatarAsset),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: MyTextStyle.text18.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(job, style: MyTextStyle.text14),

          const SizedBox(height: 30),
          Card(
            color: Colors.grey[50],
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  _buildInfoRow("Nama", name),
                  const SizedBox(height: 10),
                  _buildInfoRow("Umur", age),
                  const SizedBox(height: 10),
                  _buildInfoRow("Profesi", job),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                tokenProvider.logOut(context, onSuccess: () {
                  context.go('/');
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: MyColor.primary,
              ),
              child: Text(
                'Logout',
                style: MyTextStyle.text16.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '© 2025 ShrimpCare',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: MyTextStyle.text14.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: Text(value, style: MyTextStyle.text14),
        ),
      ],
    );
  }

  String _getAvatarAsset(String job) {
    final lowerJob = job.toLowerCase();
    return avatarMap[lowerJob] ?? 'assets/images/avatars/user.png';
  }
}

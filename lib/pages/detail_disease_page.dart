import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/disease.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/widgets/app_bar.dart';

class DetailDiseasePage extends StatefulWidget {
  const DetailDiseasePage({super.key});

  @override
  State<DetailDiseasePage> createState() => _DetailDiseasePageState();
}

class _DetailDiseasePageState extends State<DetailDiseasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final riskDetails = MyDisease.getRiskDetails(4);

    return Scaffold(
      backgroundColor: MyColor.themeColor,
      appBar: CustomAppBar(
        title: "Detail Diagnosis",
      ),
      body: Column(
        children: [
          Container(
            height: 288,
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bintik Putih (White Spot Disease)",
                        style: MyTextStyle.text18.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.warning,
                              color: riskDetails.riskColor, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Risiko ${riskDetails.riskText}',
                            style: MyTextStyle.text14.copyWith(
                              color: riskDetails.riskColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCustomTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInformasiTab(),
                _buildPencegahanTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildTabItem(title: "Informasi", index: 0),
          _buildTabItem(title: "Pencegahan", index: 1),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    bool isSelected = _tabController.index == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: MyTextStyle.text14.copyWith(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformasiTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardDiseaseDetail("Pengertian",
              "Bintik putih atau White Spot Disease (WSD) adalah penyakit viral yang disebabkan oleh White Spot Syndrome Virus (WSSV). Penyakit ini sangat menular dan dapat menyebabkan kematian massal pada udang dalam waktu singkat."),
          _cardDiseaseDetail("Gejala",
              "Muncul bintik-bintik putih pada cangkang dan tubuh udang, Udang menjadi lemas dan bergerak lambat, Nafsu makan menurun atau berhenti makan, Udang sering naik ke permukaan air dan berenang tidak teratur, Kematian mendadak dalam jumlah besar"),
          _cardDiseaseDetail("Penyebab",
              "Infeksi White Spot Syndrome Virus (WSSV)Perubahan suhu air yang drastisKualitas air buruk, seperti kadar amonia tinggiPadat tebar udang terlalu tinggi Udang stres akibat lingkungan tidak stabil, Penyebaran melalui air, udang yang terinfeksi, atau peralatan tambak yang tidak steril."),
          _cardDiseaseDetail("Info lebih lanjut", "Belum ada data."),
        ],
      ),
    );
  }

  Widget _cardDiseaseDetail(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTextStyle.text16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: MyTextStyle.text14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPencegahanTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Pencegahan"),
          _buildBulletList([
            "Menjaga kualitas air (suhu stabil, kadar oksigen cukup, dan amonia rendah).",
            "Menggunakan benur bebas WSSV dari hatchery terpercaya.",
            "Mengontrol padat tebar agar tidak terlalu tinggi.",
            "Memberikan pakan bergizi untuk meningkatkan daya tahan tubuh udang.",
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: MyTextStyle.text16.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 6, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item, style: MyTextStyle.text14)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

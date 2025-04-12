import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/disease_provider.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/disease.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailDiseasePage extends StatefulWidget {
  final String id;
  const DetailDiseasePage({super.key, required this.id});

  @override
  State<DetailDiseasePage> createState() => _DetailDiseasePageState();
}

class _DetailDiseasePageState extends State<DetailDiseasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DiseaseProvider>(context, listen: false)
          .fetchDiseasesById(widget.id);
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.themeColor,
      appBar: CustomAppBar(
        title: "Detail Penyakit",
      ),
      body: Consumer<DiseaseProvider>(
          builder: (context, detailDiseaseProvider, child) {
        final detail = detailDiseaseProvider.selectedDisease;
        final riskDetails = MyDisease.getRiskDetails(detail.riskLevel!);

        if (detailDiseaseProvider.diseases.isEmpty) {
          return nullState(nullTitle: "Data tidak ditemukan");
        }

        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: detailDiseaseProvider.isLoading,
          child: Column(
            children: [
              Container(
                height: 288,
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    Image.network(
                      // detail.imageDisease!,
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
                            detail.nameDisease!,
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
                    _tabInformasi(
                      definition: detail.definitionDisease!,
                      symptoms: detail.symtomsDisease!,
                      causes: detail.causesDisease!,
                      moreInfo: detail.moreInformation!,
                    ),
                    _tabPencegahan(
                      prevention: detail.preventionDisease!,
                      recommendation: detail.recomendationDisease!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
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

  Widget _cardDiseaseDetail(String title, String description) {
    IconData icon = Icons.question_mark_outlined;
    if (title == AppConstants.detailDiseaseTitleGejala) {
      icon = Icons.manage_search;
    } else if (title == AppConstants.detailDiseaseTitlePenyebab) {
      icon = Icons.warning_amber_outlined;
    } else if (title == AppConstants.detailDiseaseTitleInfo) {
      icon = Icons.medical_information_rounded;
    } else if (title == AppConstants.detailDiseaseTitlePencegahan) {
      icon = Icons.check_circle_outline;
    } else if (title == AppConstants.detailDiseaseTitleRekomendasi) {
      icon = Icons.recommend;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: MyTextStyle.text16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: MyTextStyle.text14),
        ],
      ),
    );
  }

  Widget _tabInformasi({
    String? definition,
    String? symptoms,
    String? causes,
    String? moreInfo,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardDiseaseDetail(
              AppConstants.detailDiseaseTitlePengertian, definition ?? "-"),
          _cardDiseaseDetail(
              AppConstants.detailDiseaseTitleGejala, symptoms ?? "-"),
          _cardDiseaseDetail(
              AppConstants.detailDiseaseTitlePenyebab, causes ?? "-"),
          _cardDiseaseDetail(
              AppConstants.detailDiseaseTitleInfo, moreInfo ?? "-"),
        ],
      ),
    );
  }

  Widget _tabPencegahan({
    String? prevention,
    String? recommendation,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardDiseaseDetail(
              AppConstants.detailDiseaseTitlePencegahan, prevention ?? "-"),
          _cardDiseaseDetail(AppConstants.detailDiseaseTitleRekomendasi,
              recommendation ?? "-"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

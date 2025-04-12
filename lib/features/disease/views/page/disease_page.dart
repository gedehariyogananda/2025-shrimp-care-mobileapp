import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/disease_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/views/widget/disease_card.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DiseasePage extends StatefulWidget {
  @override
  _DiseasePageState createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  String selectedSort = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DiseaseProvider>(context, listen: false).fetchDiseaseAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiseaseProvider>(builder: (context, diseaseProvider, _) {
      return Scaffold(
        appBar: CustomAppBar(title: "Penyakit"),
        backgroundColor: MyColor.themeColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 130,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Penyakit Udang",
                      style: MyTextStyle.text20.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              diseaseProvider.setSearch(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Cari..",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.search,
                                  color: Colors.grey.shade600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColor.primary),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.tune, color: Colors.black),
                            onPressed: () {
                              _showSortBottomSheet(context, diseaseProvider);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: diseaseProvider.diseases.isEmpty
                    ? Expanded(
                        child: Center(
                            child: nullState(nullTitle: "Belum ada data!")))
                    : Skeletonizer(
                        enabled: diseaseProvider.isLoading,
                        enableSwitchAnimation: true,
                        child: Column(
                          children: List.generate(
                            diseaseProvider.diseases.length,
                            (index) {
                              final disease = diseaseProvider.diseases[index];
                              return Column(
                                children: [
                                  diseaseCard(
                                    title: disease.nameDisease!,
                                    // image: disease.imageDisease!,
                                    image:
                                        "https://strapi.jala.tech/uploads/contoh_udang_yang_terkena_penyakit_black_spot_disease_41098d2b90.jpg",
                                    risk: disease.riskLevel!,
                                    description: disease.descriptionDisease!,
                                    onTap: () {
                                      context.pushNamed(
                                        'detail_disease',
                                        pathParameters: {
                                          'id': disease.id!,
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showSortBottomSheet(
      BuildContext context, DiseaseProvider diseaseProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "Urutkan",
                              style: MyTextStyle.text18.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Risiko Penyakit",
                        style: MyTextStyle.text16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Radio<String>(
                        value: "-risk_level",
                        groupValue: selectedSort,
                        activeColor: MyColor.primary,
                        onChanged: (value) {
                          setModalState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                      title: Text("Tinggi - Rendah"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Radio<String>(
                        value: "risk_level",
                        groupValue: selectedSort,
                        activeColor: MyColor.primary,
                        onChanged: (value) {
                          setModalState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                      title: Text("Rendah - Tinggi"),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          final diseaseProvider = Provider.of<DiseaseProvider>(
                              context,
                              listen: false);

                          diseaseProvider.setPrefixSort(selectedSort);

                          Navigator.pop(context);
                        },
                        child: Text(
                          "Terapkan",
                          style:
                              MyTextStyle.text16.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

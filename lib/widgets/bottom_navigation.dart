import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/pages/core/akun_page.dart';
import 'package:shrimp_care_mobileapp/pages/core/diagnosa_page.dart';
import 'package:shrimp_care_mobileapp/pages/core/home_page.dart';
import 'package:shrimp_care_mobileapp/pages/core/sampling_page.dart';
import 'package:shrimp_care_mobileapp/pages/detail_sampling_page.dart';
import 'package:shrimp_care_mobileapp/pages/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'package:shrimp_care_mobileapp/widgets/app_bar.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  int? _selectedMethod;

  final List<String> _pageTitles = [
    'Home',
    'Diagnosa',
    'Input Data',
    'Sampling',
    'Akun',
  ];

  void _onItemTapped(int index) {
    if (index == 2) return;
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _showInputBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inputan Cepat",
                      style: MyTextStyle.text20.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Pilih metode yang ingin kamu lakukan:",
                      style: MyTextStyle.text14,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: MyColor.softSecondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setModalState(() => _selectedMethod = 0);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedMethod == 0
                                      ? MyColor.primary
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio<int>(
                                    value: 0,
                                    groupValue: _selectedMethod,
                                    onChanged: (value) {
                                      setModalState(
                                          () => _selectedMethod = value);
                                    },
                                    activeColor: MyColor.primary,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(16),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff167CF8),
                                            Color(0xff024EAB),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.search_off_sharp,
                                            color: Colors.white),
                                      )),
                                  const SizedBox(width: 11),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Diagnosis Udang",
                                        style: MyTextStyle.text16.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "Periksa kondisi udangmu",
                                        style: MyTextStyle.text12,
                                      ),
                                      const Text(
                                        "dan dapatkan hasil",
                                        style: MyTextStyle.text12,
                                      ),
                                      const Text(
                                        "diagnosisnya.",
                                        style: MyTextStyle.text12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              setModalState(() => _selectedMethod = 1);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedMethod == 1
                                      ? MyColor.primary
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _selectedMethod,
                                    onChanged: (value) {
                                      setModalState(
                                          () => _selectedMethod = value);
                                    },
                                    activeColor: MyColor.primary,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(16),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff33A09D),
                                            Color(0xff1E3836),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.science_outlined,
                                            color: Colors.white),
                                      )),
                                  const SizedBox(width: 11),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sampling",
                                        style: MyTextStyle.text16.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "Input data sampel untuk",
                                        style: MyTextStyle.text12,
                                      ),
                                      const Text(
                                        "analisis lebih lanjut dan",
                                        style: MyTextStyle.text12,
                                      ),
                                      const Text(
                                        "lihat grafik hasilnya.",
                                        style: MyTextStyle.text12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedMethod == null
                            ? null
                            : () {
                                Navigator.pop(context);
                                if (_selectedMethod == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DiagnosisPage(),
                                      ));
                                } else if (_selectedMethod == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailSamplingPage(),
                                      ));
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primary,
                          disabledBackgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          "Lanjut",
                          style: MyTextStyle.text14.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToPage(int pageIndex) {
    setState(() {
      _selectedIndex = pageIndex;
    });
    _pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFEDF1F7),
        appBar: _selectedIndex == 0
            ? null
            : CustomAppBar(
                title: _pageTitles[_selectedIndex],
                showRightButton: _selectedIndex == 1,
                iconButton: Icons.add,
                onRightButtonPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiagnosisPage(),
                      ));
                },
              ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            HomePage(),
            DiagnosaPage(),
            InputPage(),
            SamplingPage(),
            AkunPage(),
          ],
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // Bottom Navigation Bar
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: MyColor.primary,
                unselectedItemColor: MyColor.secondary,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.medical_services),
                    label: 'Diagnosa',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.science),
                    label: 'Sampling',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Akun',
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton(
                      onPressed: _showInputBottomSheet,
                      backgroundColor: MyColor.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.add, size: 30),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Input',
                    style: MyTextStyle.text12.copyWith(
                      color: _selectedIndex == 2
                          ? MyColor.primary
                          : MyColor.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}

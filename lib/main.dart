import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shrimp_care_mobileapp/constant/const.dart';
import 'package:shrimp_care_mobileapp/pages/splash_screen_page.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(AppConstants.initializedLang, null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColor.themeColor,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color(0xFFEDF1F7),
        ),
      ),
      home: SplashScreenPage(),
    );
  }
}

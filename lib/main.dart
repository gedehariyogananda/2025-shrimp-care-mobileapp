import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/config/database.dart';
import 'package:shrimp_care_mobileapp/features/_auth/providers/login_provider.dart';
import 'package:shrimp_care_mobileapp/features/_auth/providers/register_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/providers/diagnosa_provider.dart';
import 'package:shrimp_care_mobileapp/features/disease/providers/diseases_provider.dart';
import 'package:shrimp_care_mobileapp/features/home/providers/greeting_provider.dart';
import 'package:shrimp_care_mobileapp/features/repositories/diagnosis_detail_repository.dart';
import 'package:shrimp_care_mobileapp/features/repositories/diagnosis_repository.dart';
import 'package:shrimp_care_mobileapp/services/diagnosis_service.dart';
import 'package:shrimp_care_mobileapp/start/routes.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(AppConstants.initializedLang, null);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final db = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GreetingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiseasesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiagnosaProvider(DiagnosisServices(
            DiagnosisRepository(db),
            DiagnosisDetailRepository(db),
          )),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColor.themeColor,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Color(0xFFEDF1F7),
          ),
        ),
      ),
    );
  }
}

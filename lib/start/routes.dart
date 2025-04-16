import 'package:go_router/go_router.dart';
import 'package:shrimp_care_mobileapp/base/components/page/splash_screen_page.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/features/auth/views/page/login_page.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/bottom_navigation.dart';
import 'package:shrimp_care_mobileapp/features/auth/views/page/register_page.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/page/diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/page/history_diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/views/page/result_diagnosis_page.dart';
import 'package:shrimp_care_mobileapp/features/disease/views/page/detail_disease_page.dart';
import 'package:shrimp_care_mobileapp/features/disease/views/page/disease_page.dart';
import 'package:shrimp_care_mobileapp/features/sampling/views/page/detail_sampling_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashScreenPage();
      }),
  GoRoute(
      path: '/home_page',
      name: 'home_page',
      builder: (context, state) {
        return BottomNavigation();
      },
      routes: [
        GoRoute(
          path: 'disease',
          name: 'disease',
          builder: (context, state) {
            return DiseasePage();
          },
        ),
        GoRoute(
          path: 'diagnosis',
          name: 'diagnosis',
          builder: (context, state) {
            return DiagnosisPage();
          },
        ),
        GoRoute(
          path: 'sampling',
          name: 'sampling',
          builder: (context, state) {
            return DetailSamplingPage();
          },
        ),
        GoRoute(
          path: 'riwayat_diagnosis',
          name: 'riwayat_diagnosis',
          builder: (context, state) {
            return HistoryDiagnosisPage();
          },
        ),
        GoRoute(
          path: 'detail_disease/:id',
          name: 'detail_disease',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return DetailDiseasePage(
              id: id!,
            );
          },
        ),
        GoRoute(
            path: 'detail_diagnosis/:id',
            name: 'detail_diagnosis',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return ResultDiagnosisPage(
                id: id!,
              );
            }),
      ]),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) {
      return LoginPage();
    },
  ),
  GoRoute(
    path: '/register',
    name: 'register',
    builder: (context, state) {
      return RegisterPage();
    },
  ),
  GoRoute(
    path: '/session',
    name: 'session',
    redirect: (context, state) async {
      String? token =
          await TokenProvider().getDataLocal(AppConstants.keySharedPrefToken);
      if (token != null) {
        return '/home_page';
      } else {
        return '/login';
      }
    },
  ),
], initialLocation: '/', routerNeglect: true);

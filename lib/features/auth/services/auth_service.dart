import 'package:shrimp_care_mobileapp/features/diagnosis/repositories/diagnosis_detail_repository.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/repositories/diagnosis_repository.dart';

class AuthService {
  final DiagnosisDetailRepository diagnosisDetailRepository;
  final DiagnosisRepository diagnosisRepository;

  AuthService({
    required this.diagnosisDetailRepository,
    required this.diagnosisRepository,
  });

  Future<void> clearAllData() async {
    await diagnosisDetailRepository.clearAllData();
    await diagnosisRepository.clearAllData();
  }
}

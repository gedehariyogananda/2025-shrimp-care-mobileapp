import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';

class MyDisease {
  static RiskDetails getRiskDetails(int risk) {
    if (risk >= 1 && risk <= 2) {
      return RiskDetails('Rendah', MyColor.primary);
    } else if (risk >= 3 && risk <= 4) {
      return RiskDetails('Sedang', MyColor.warning);
    } else if (risk == 5) {
      return RiskDetails('Tinggi', MyColor.danger);
    } else {
      return RiskDetails('Normal', Colors.black);
    }
  }

  static Color getColorByAccuracy(int accuracy) {
    if (accuracy <= 40) {
      return MyColor.danger;
    } else if (accuracy <= 70) {
      return MyColor.warning;
    } else {
      return MyColor.primary;
    }
  }
}

class RiskDetails {
  final String riskText;
  final Color riskColor;

  RiskDetails(this.riskText, this.riskColor);
}

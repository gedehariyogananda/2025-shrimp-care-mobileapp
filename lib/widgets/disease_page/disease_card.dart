import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget diseaseCard({
  required String image,
  required String title,
  required String description,
  required int risk,
  required VoidCallback onTap,
}) {
  String riskText;
  Color riskColor;

  if (risk >= 1 && risk <= 2) {
    riskText = 'Rendah';
    riskColor = MyColor.primary;
  } else if (risk >= 3 && risk <= 4) {
    riskText = 'Sedang';
    riskColor = MyColor.warning;
  } else if (risk == 5) {
    riskText = 'Tinggi';
    riskColor = MyColor.danger;
  } else {
    riskText = 'Normal';
    riskColor = Colors.black;
  }

  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: 125,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  image,
                  width: 78,
                  height: 88,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MyTextStyle.text16.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      style: MyTextStyle.text14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.warning, color: riskColor, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'Risiko $riskText',
                          style: MyTextStyle.text14.copyWith(
                            color: riskColor,
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
      ),
    ),
  );
}

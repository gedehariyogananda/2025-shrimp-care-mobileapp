import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget diagnosisCard({
  required String image,
  required String title,
  required int accuracy,
  String? date,
  required VoidCallback onTap,
}) {
  Color accuracyColor;

  if (accuracy <= 40) {
    accuracyColor = MyColor.danger;
  } else if (accuracy <= 70) {
    accuracyColor = MyColor.warning;
  } else {
    accuracyColor = MyColor.primary;
  }

  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: 124,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
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
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 6.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: accuracy / 100,
                          child: Container(
                            height: 6.0,
                            decoration: BoxDecoration(
                              color: accuracyColor,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.line_axis_outlined,
                          size: 16.0,
                          color: accuracyColor,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          "Akurasi $accuracy / 100%",
                          style: MyTextStyle.text12.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    if (date != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            date,
                            style: MyTextStyle.text12.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

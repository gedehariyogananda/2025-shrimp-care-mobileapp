import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/features/disease/views/widget/disease_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget diseaseLoader({
  bool isLoading = true,
}) {
  return Skeletonizer(
    enableSwitchAnimation: true,
    enabled: isLoading,
    child: Column(
      children: List.generate(
        7,
        (index) {
          return Column(
            children: [
              diseaseCard(
                title: "",
                image: "-",
                risk: 0,
                description: "",
                onTap: () {},
              ),
            ],
          );
        },
      ),
    ),
  );
}

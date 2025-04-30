import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget detailDiseaseLoader({
  bool isLoading = true,
}) {
  return Skeletonizer(
    enableSwitchAnimation: true,
    enabled: isLoading,
    child: Column(
      children: [
        Container(
          height: 288,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 200,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 16,
                      width: 150,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 40,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 4,
            itemBuilder: (_, __) => Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

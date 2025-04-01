import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';

Future<void> loadingScreen(BuildContext context,
    {required String title, required String description}) async {
  Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false, 
      pageBuilder: (context, _, __) => Scaffold(
        backgroundColor: MyColor.primary, 
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white, strokeWidth: 6),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

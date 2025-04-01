import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/widgets/app_bar.dart';
import 'package:shrimp_care_mobileapp/widgets/null_state.dart';

class DetailSamplingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Samping"),
      body: Center(
        child: nullState(
          nullTitle: "Sampling",
          description: "Fitur ini akan datang secepatnya!",
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Login"),
      body: Center(
        child: nullState(
          nullTitle: "Login",
          description: "Fitur ini akan datang secepatnya!",
        ),
      ),
    );
  }
}

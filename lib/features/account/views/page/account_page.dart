import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/utils/null_state.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: nullState(
          nullTitle: "Akun",
          description: "Fitur ini akan datang secepatnya!",
          buttonTitle: "Logout",
          onTap: () {
            context.read<TokenProvider>().logOut(context, onSuccess: () {
              context.go('/login');
            });
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:store_app2/features/presentation/profile/widgets/profile_info_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60),
        child: ProfileInfoBody(),
      ),
    );
  }
}

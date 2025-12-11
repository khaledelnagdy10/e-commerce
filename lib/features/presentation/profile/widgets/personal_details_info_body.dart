import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/profile/widgets/change_user_name.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/change_password.dart';
import 'package:store_app2/features/presentation/profile/widgets/change_user_address.dart';

class PersonalDetailsInfoBody extends StatefulWidget {
  const PersonalDetailsInfoBody({super.key});

  @override
  State<PersonalDetailsInfoBody> createState() =>
      _PersonalDetailsInfoBodyState();
}

class _PersonalDetailsInfoBodyState extends State<PersonalDetailsInfoBody> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

  String buildPassword(String password, bool googleAccount) {
    if (googleAccount) return "*" * 10;
    return "*" * password.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          final userData = cubit.userData;

          if (state is AuthLoading || userData.isEmpty) {
            return const Center(child: Text('Loading profile...'));
          }

          if (state is AuthGetUserSuccess) {
            final address = userData['address'] ?? {};
            final password = userData['password'];
            final googleAccount = userData['googleAccount'] == true;

            final hiddenPassword = buildPassword(password, googleAccount);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Profile', style: Style.textStyleBoldHeadLine),
                  Text('Personal Details', style: Style.textStyleBold16Black),
                  const SizedBox(height: 35),

                  // Email
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    title: Text('Email', style: Style.textStyle12grey),
                    subtitle: Text(userData['email']),
                  ),

                  const SizedBox(height: 20),

                  // Name
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Full name', style: Style.textStyle14grey),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => ChangeUserName(),
                          ),
                          child: const Text(
                            'edit',
                            style: Style.textStyle14grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(userData['name']),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Address
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Address', style: Style.textStyle12grey),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => const ChangeUserAddress(),
                          ),
                          child: const Text(
                            'edit',
                            style: Style.textStyle14grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "${address['city'] ?? ''}, ${address['region'] ?? ''}, ${address['street'] ?? ''}",
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Password header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Password', style: Style.textStyleBold24Black),
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (_) => const ChangePassword(),
                        ),
                        child: Text('Change', style: Style.textStyle14grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Password
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    title: Text('Password', style: Style.textStyle12grey),
                    subtitle: Text(hiddenPassword),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

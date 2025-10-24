import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class ProfileInfoBody extends StatefulWidget {
  const ProfileInfoBody({super.key});

  @override
  State<ProfileInfoBody> createState() => _ProfileInfoBodyState();
}

class _ProfileInfoBodyState extends State<ProfileInfoBody> {
  @override
  void initState() {
    context.read<AuthCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final userData = context.read<AuthCubit>().userData;
        if (state is AuthSuccess) {
          final cubit = context.read<AuthCubit>();
          final password = cubit.userData['password'];
          String hiddenPassword = '*';
          hiddenPassword =
              context.read<AuthCubit>().userData['googleAccount'] == true
              ? hiddenPassword * 10
              : hiddenPassword * password.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Profile', style: Style.textStyleBoldHeadLine),
              SizedBox(height: 20),

              ListTile(
                tileColor: Colors.white,
                title: Text('email', style: Style.textStyle11grey),
                subtitle: Text(userData['name']),
              ),
              SizedBox(height: 20),
              ListTile(
                tileColor: Colors.white,
                title: Text('Email', style: Style.textStyle11grey),
                subtitle: Text(userData['email']),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Password', style: Style.textStyleBold24Black),
                  GestureDetector(
                    onTap: () async {
                      await context
                          .read<AuthCubit>()
                          .authService
                          .sendPasswordResetEmail(email: userData['email']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password reset email sent!')),
                      );
                    },
                    child: Text('Change', style: Style.textStyle14grey),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListTile(
                tileColor: Colors.white,
                title: Text('Password', style: Style.textStyle11grey),

                subtitle: Text(hiddenPassword),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

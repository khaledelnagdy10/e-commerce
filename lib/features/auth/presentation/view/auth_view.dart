import 'dart:developer';

import 'package:e_commerce_app/core/helpers/dialogs.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/custom_text_form_feild.dart';
import 'package:e_commerce_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingDialog.show(context);
        }

        if (state is AuthFailure) {
          LoadingDialog.hide(context);
          AppDialogs.error(context, message: "An error occured");
        }

        if (state is AuthSuccess) {
          LoadingDialog.hide(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
        }

        log("AuthView - BlocListener - state: $state");
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 10.0, right: 10),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 34),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    const CustomTextFormField(
                      labelText: 'Email',
                    ),
                    const SizedBox(height: 20),
                    const CustomTextFormField(
                      labelText: 'Password',
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Forgot your password'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      onPressed: () {
                        cubit.login(email: 'emilys', password: 'emilyspass');
                      },
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Text(
                          'Or login with social account',
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/Google.png'),
                            Image.asset('assets/images/Facebook.png'),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

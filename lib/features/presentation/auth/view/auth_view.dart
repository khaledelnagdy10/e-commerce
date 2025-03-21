import 'package:e_commerce_app/features/presentation/auth/controller/authCubit/auth_cubit.dart';
import 'package:e_commerce_app/features/presentation/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/features/presentation/auth/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 10.0, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AuthSuccess) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 34),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    const CustomTextFormField(
                      labelText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomTextFormField(
                      labelText: 'Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Forgot your password'),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      onPressed: () {
                        context
                            .read<AuthCubit>()
                            .post(email: 'emilys', password: 'emilyspass');
                      },
                    ),
                    const SizedBox(
                      height: 190,
                    ),
                    const Text('Or login with social account'),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/Google.png'),
                        Image.asset('assets/images/Facebook.png')
                      ],
                    )
                  ],
                );
              }
              if (state is AuthFailure) {
                return const Text('There was an error');
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

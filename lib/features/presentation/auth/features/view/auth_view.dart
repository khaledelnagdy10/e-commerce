import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/core/utils/widgets/custom_scaffold_messenger.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/auth/features/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/home/features/view/home_view.dart';
import 'package:store_app2/features/presentation/home/features/widgets/custom_button.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key, required this.authType});
  int authType;
  String fullName = '';
  String email = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: authType == 1
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              )
            : SizedBox(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthFailure) {
            customScaffoldMessenger(
              context,
              message: state.errorModel.errMessage,
              color: Colors.red,
            );
          }
          if (state is AuthSuccess) {
            if (authType == 0) {
              customScaffoldMessenger(
                context,
                message: 'sign Up Successfully ',
                color: Colors.green,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuthView(authType: 1);
                  },
                ),
              );
            }
            if (authType == 1) {
              log(authType.toString());
              customScaffoldMessenger(
                context,
                message: 'Login Successfully ',
                color: Colors.green,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeView();
                  },
                ),
              );
            }
          }
        },

        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          authType == 0 ? 'Sign up' : 'Login',
                          style: Style.textStyleBoldHeadLine,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    authType == 0
                        ? CustomTextFormField(
                            title: 'Full Name',
                            onChanged: (value) {
                              fullName = value;
                            },
                          )
                        : SizedBox(height: 70),
                    CustomTextFormField(
                      title: 'Email',
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    CustomTextFormField(
                      title: 'password',
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (authType == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AuthView(authType: 1);
                                  },
                                ),
                              );
                            }
                            if (authType == 1) {
                              if (email.trim().isEmpty) {
                                customScaffoldMessenger(
                                  context,
                                  message: 'please enter your email',
                                  color: Colors.red,
                                );
                                return;
                              }

                              if (email.isNotEmpty) {
                                await context
                                    .read<AuthCubit>()
                                    .authService
                                    .sendPasswordResetEmail(email: email);
                                customScaffoldMessenger(
                                  context,
                                  message: 'check your gmail',
                                  color: Colors.green,
                                );
                                return;
                              }
                            }
                          },
                          child: authType == 0
                              ? Text('Already have an account?')
                              : Text('Forgot your password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (authType == 0) {
                            context.read<AuthCubit>().signUp(
                              fullName: fullName,
                              email: email,
                              password: password,
                            );
                          }

                          if (authType == 1) {
                            context.read<AuthCubit>().logIn(
                              email: email,
                              password: password,
                            );
                          }
                        }
                      },
                      text: authType == 0 ? 'Sign Up' : 'LogIn',
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      width: double.infinity,
                      height: 50,
                    ),
                    const SizedBox(height: 126),
                    const Text('Or sign up with social account'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<AuthCubit>().googleSignIn();
                          },
                          child: ImageAssets(
                            url: 'assets/images/google.png',
                            fit: BoxFit.cover,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            // context.read<AuthCubit>().faceBookSignIn();
                          },
                          child: ImageAssets(
                            url: 'assets/images/facebook.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

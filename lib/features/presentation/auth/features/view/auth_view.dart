import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/address_model.dart';
import 'package:store_app2/core/utils/widgets/custom_scaffold_messenger.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/core/utils/widgets/error_alert_dialog.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/auth/features/widgets/email_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/widgets/password_text_form_field.dart';

import 'package:store_app2/features/presentation/home/features/view/home_view.dart';
import 'package:store_app2/features/presentation/home/features/widgets/custom_button.dart';

class AuthView extends StatefulWidget {
  AuthView({super.key, required this.authType});
  int authType;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String fullName = '';

  String email = '';

  String password = '';

  Map<String, dynamic> address = {'city': '', 'region': '', 'street': ''};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.authType == 1
            ? IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AuthView(authType: 0);
                      },
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back_ios_new),
              )
            : SizedBox(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthLogoutSuccess) {
            context.read<AuthCubit>().userData = {};
          }
          if (state is AuthFailure) {
            customScaffoldMessenger(
              context,
              message: state.errorModel.errMessage,
              color: Colors.red,
            );
          }
          if (state is AuthSignUpSuccess) {
            if (widget.authType == 0) {
              customScaffoldMessenger(
                context,
                message: 'Check your gmail to verify account',
                color: Colors.green,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuthView(authType: 1);
                  },
                ),
              );
            }
          }
          if (state is AuthLoginSuccess) {
            if (widget.authType == 1) {
              log(widget.authType.toString());
              customScaffoldMessenger(
                context,
                message: 'Login Successfully ',
                color: Colors.green,
              );

              Navigator.pushReplacement(
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.authType == 0 ? 'Sign up' : 'Login',
                          style: Style.textStyleBoldHeadLine,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    widget.authType == 0
                        ? Column(
                            children: [
                              CustomTextFormField(
                                title: 'Full Name',
                                onChanged: (value) {
                                  fullName = value!;
                                },
                              ),
                              CustomTextFormField(
                                title: 'City',
                                onChanged: (city) {
                                  address['city'] = city!;
                                },
                              ),
                              CustomTextFormField(
                                title: 'Region',
                                onChanged: (region) {
                                  address['region'] = region!;
                                },
                              ),
                              CustomTextFormField(
                                title: 'Street',
                                onChanged: (street) {
                                  address['street'] = street!;
                                },
                              ),
                            ],
                          )
                        : SizedBox(height: 70),
                    EmailTextFormField(
                      title: 'Email',
                      onChanged: (value) {
                        email = value!;
                      },
                    ),
                    PasswordTextFormField(
                      title: 'password',
                      onChanged: (value) {
                        password = value!;
                      },
                      authType: widget.authType,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (widget.authType == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AuthView(authType: 1);
                                  },
                                ),
                              );
                            }
                            if (widget.authType == 1) {
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
                          child: widget.authType == 0
                              ? Text('Already have an account?')
                              : Text('Forgot your password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (widget.authType == 0) {
                            context.read<AuthCubit>().signUp(
                              fullName: fullName,
                              email: email,
                              password: password,
                              address: AddressModel.fromJson(address),
                            );
                          }

                          if (widget.authType == 1) {
                            context.read<AuthCubit>().logIn(
                              email: email,
                              password: password,
                            );
                          }
                        }
                      },
                      text: widget.authType == 0 ? 'Sign Up' : 'LogIn',
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      width: double.infinity,
                      height: 50,
                    ),
                    widget.authType == 0
                        ? const SizedBox(height: 10)
                        : const SizedBox(height: 126),
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

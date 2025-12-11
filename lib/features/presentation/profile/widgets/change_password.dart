import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/widgets/custom_scaffold_messenger.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPassword = '';
  String newPassword = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final userData = authCubit.userData;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              title: 'current password',
              initialValue: userData['googleAccount'] ? '**********' : '',
              readOnly: userData['googleAccount'] == true ? true : false,
              onChanged: (value) {
                oldPassword = value!;
              },
            ),
            SizedBox(height: 15),
            CustomTextFormField(
              title: 'new password',
              onChanged: (value) {
                newPassword = value!;
              },
            ),
            SizedBox(height: 200),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (userData['googleAccount'] == true) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        content: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'google account cannot \n change password',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        actions: [
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  final storedPassword = userData['password'];
                  if (storedPassword != oldPassword) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        content: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Wrong password',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        actions: [
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  final uid = await CacheData.getData(key: 'email');
                  try {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await authCubit.firebaseFirestore.update(
                        collectionPath: 'users',
                        doc: uid,
                        data: {'password': newPassword},
                      );
                      await FirebaseAuth.instance.currentUser!.updatePassword(
                        newPassword,
                      );
                    }

                    context.read<AuthCubit>().getUserData();
                    Navigator.pop(context);
                    if (!formKey.currentState!.validate()) {
                      'please enter address';
                      return;
                    }
                    customScaffoldMessenger(
                      context,
                      message: 'Password updated successfully!',
                      color: Colors.green,
                    );
                  } catch (e) {
                    customScaffoldMessenger(
                      context,
                      message: 'Error updating password: $e',
                      color: Colors.red,
                    );
                  }
                },
                child: Text('Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class ChangeUserName extends StatefulWidget {
  ChangeUserName({super.key});

  @override
  State<ChangeUserName> createState() => _ChangeUserNameState();
}

class _ChangeUserNameState extends State<ChangeUserName> {
  String newName = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final uid = CacheData.getData(key: 'email');
    final userData = context.read<AuthCubit>().userData;
    newName = userData['name'];
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            CustomTextFormField(
              title: 'Your Name',
              initialValue: userData['name'],
              readOnly: true,
              onChanged: (_) {},
            ),
            SizedBox(height: 15),
            CustomTextFormField(
              title: 'New Name',
              onChanged: (value) {
                newName = value!;
              },
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await context.read<AuthCubit>().firebaseFirestore.update(
                        collectionPath: 'users',
                        doc: uid,
                        data: {'name': newName},
                      );
                    }
                    context.read<AuthCubit>().getUserData();

                    Navigator.pop(context);
                  } catch (e) {
                    if (!formKey.currentState!.validate()) {
                      'please enter data';
                      return;
                    }
                  }
                },
                child: Text('Change Name'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

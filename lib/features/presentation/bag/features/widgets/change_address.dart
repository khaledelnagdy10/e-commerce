import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class ChangeAddress extends StatelessWidget {
  ChangeAddress({super.key});
  String newAddress = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().userData;
    final uid = CacheData.getData(key: 'email');
    return SizedBox(
      height: 400,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                title: 'Your address',
                initialValue: userData['address'],
                readOnly: true,
                onChanged: (_) {
                  return;
                },
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                title: 'New address',

                onChanged: (value) {
                  newAddress = value;
                },
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  if (!_formKey.currentState!.validate()) {
                    'please enter address';
                    return;
                  }
                  context.read<AuthCubit>().firebaseFirestore.update(
                    collectionPath: 'users',
                    doc: uid,
                    data: {'address': newAddress},
                  );
                  await context.read<AuthCubit>().getUserData();
                  Navigator.pop(context, newAddress);
                },
                child: Text('Change Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

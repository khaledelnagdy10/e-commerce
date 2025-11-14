import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/auth/features/widgets/custom_text_form_field.dart';

class ChangeAddress extends StatelessWidget {
  ChangeAddress({super.key});
  String newAddress = '';
  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().userData;
    final uid = CacheData.getData(key: 'email');
    return SizedBox(
      height: 400,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
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
              onPressed: () {
                context.read<AuthCubit>().firebaseFirestore.update(
                  collectionPath: 'users',
                  doc: uid,
                  data: {'address': newAddress},
                );
                Navigator.pop(context);
              },
              child: Text('Change Address'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/models/address_model.dart';

import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class ChangeUserAddress extends StatefulWidget {
  const ChangeUserAddress({super.key});

  @override
  State<ChangeUserAddress> createState() => _ChangeUserAddressState();
}

class _ChangeUserAddressState extends State<ChangeUserAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final uid = CacheData.getData(key: 'email');
    final userAddress = Map<String, dynamic>.from(
      context.read<AuthCubit>().userData['address'] ??
          {"city": "", "region": "", "street": ""},
    );

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
                initialValue:
                    userAddress['city'] == '' &&
                        userAddress['region'] == '' &&
                        userAddress['street'] == ''
                    ? 'No Address Added'
                    : '${userAddress['city']} - ${userAddress['region']} - ${userAddress['street']}',
                readOnly: true,
                onChanged: (_) {},
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                title: 'City',

                onChanged: (city) {
                  userAddress['city'] = city!;
                },
              ),
              CustomTextFormField(
                title: 'Region',

                onChanged: (region) {
                  userAddress['region'] = region!;
                },
              ),

              CustomTextFormField(
                title: 'Street',

                onChanged: (street) {
                  userAddress['street'] = street!;
                },
              ),
              Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await context.read<AuthCubit>().firebaseFirestore.update(
                        collectionPath: 'users',
                        doc: uid,
                        data: {'address': userAddress},
                      );
                    }
                    await context.read<AuthCubit>().getUserData();
                    Navigator.pop(context);
                    if (!_formKey.currentState!.validate()) {
                      'please enter address';
                      return;
                    }
                  },
                  child: Text('Change Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

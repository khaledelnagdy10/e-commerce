import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class ChangeAddress extends StatelessWidget {
  ChangeAddress({super.key, required this.order});
  final MyOrdersModel order;
  String newAddress = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String userAddress = context.read<AuthCubit>().userData['address'];
    newAddress = userAddress;
    return SizedBox(
      height: 350,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Form(
          key: _formKey,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                title: 'Your address',
                initialValue: order.address,
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
              Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await context.read<MyOrderCubit>().updateOrderAddress(
                        order.id!,
                        newAddress,
                      );

                      Navigator.pop(context);
                    }
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

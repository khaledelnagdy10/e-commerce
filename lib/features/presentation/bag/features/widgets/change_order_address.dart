import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/address_model.dart';

import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class ChangeOrderAddress extends StatefulWidget {
  const ChangeOrderAddress({super.key, required this.originalAddress});
  final Map<String, dynamic> originalAddress;
  @override
  State<ChangeOrderAddress> createState() => _ChangeOrderAddressState();
}

class _ChangeOrderAddressState extends State<ChangeOrderAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> updatedAddress = {
    'city': '',
    'region': '',
    'street': '',
  };
  @override
  Widget build(BuildContext context) {
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
                    '${widget.originalAddress['city']},${widget.originalAddress['region']},${widget.originalAddress['street']}}',
                readOnly: true,
                onChanged: (_) {
                  return;
                },
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                title: 'City',

                onChanged: (city) {
                  setState(() {
                    updatedAddress['city'] = city;
                  });
                },
              ),
              CustomTextFormField(
                title: 'Region',

                onChanged: (region) {
                  setState(() {
                    updatedAddress['region'] = region;
                  });
                },
              ),

              CustomTextFormField(
                title: 'Street',

                onChanged: (street) {
                  setState(() {
                    updatedAddress['street'] = street;
                  });
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
                      Navigator.pop(context, updatedAddress);
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

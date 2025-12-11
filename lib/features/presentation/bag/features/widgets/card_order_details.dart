import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';

import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/change_order_address.dart';

class CardOrderDetails extends StatefulWidget {
  const CardOrderDetails({super.key, required this.onAddressChanged});
  final Function(Map<String, dynamic>) onAddressChanged;

  @override
  State<CardOrderDetails> createState() => _CardOrderDetailsState();
}

class _CardOrderDetailsState extends State<CardOrderDetails> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

  Map<String, dynamic>? updatedAddress;
  Map<String, dynamic> orderAddress = {'city': '', 'region': '', 'street': ''};
  bool addressIsEmpty(Map? address) {
    if (address == null) return true;

    return (address['city'] == null ||
            address['city'].toString().trim().isEmpty) &&
        (address['region'] == null ||
            address['region'].toString().trim().isEmpty) &&
        (address['street'] == null ||
            address['street'].toString().trim().isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final userData = context.read<AuthCubit>().userData;

        if (userData.isEmpty || userData['name'] == null) {
          return const Center(child: CircularProgressIndicator());
        }

        bool googleAccount =
            userData['googleAccount'] == true ||
            userData['googleAccount'] == "true";
        final address = Map<String, dynamic>.from(
          googleAccount
              ? (updatedAddress ?? userData['address'] ?? {})
              : (updatedAddress ?? userData['address'] ?? {}),
        );
        final bool hasAddress = !addressIsEmpty(address);
        return hasAddress
            ? Card(
                margin: EdgeInsets.all(0),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userData['name'] ?? '',
                            style: Style.textStyle16Black,
                            textAlign: TextAlign.left,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ChangeOrderAddress(
                                    originalAddress:
                                        updatedAddress ?? userData['address'],
                                  );
                                },
                              );
                              if (result != null) {
                                setState(() {
                                  updatedAddress = result;
                                });
                                widget.onAddressChanged(result);
                              }
                            },
                            child: Text(
                              'Change',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${address['city']}, ${address['region']}, ${address['street']}",
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  CustomTextFormField(
                    title: 'name',

                    initialValue: userData['name'],
                    onChanged: (value) {
                      userData['name'] = value;
                    },
                  ),
                  SizedBox(height: 10),

                  CustomTextFormField(
                    title: 'City',
                    onChanged: (value) {
                      orderAddress['city'] = value!;
                      widget.onAddressChanged(orderAddress);
                    },
                  ),

                  CustomTextFormField(
                    title: 'Region',
                    onChanged: (value) {
                      orderAddress['region'] = value!;
                      widget.onAddressChanged(orderAddress);
                    },
                  ),

                  CustomTextFormField(
                    title: 'Street',
                    onChanged: (value) {
                      orderAddress['street'] = value!;
                      widget.onAddressChanged(orderAddress);
                    },
                  ),
                ],
              );
      },
    );
  }
}

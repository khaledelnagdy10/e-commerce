import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/auth/features/view/auth_view.dart';
import 'package:store_app2/features/presentation/profile/widgets/my_order_details_info_body.dart';
import 'package:store_app2/features/presentation/profile/widgets/all_orders.dart';
import 'package:store_app2/features/presentation/profile/widgets/personal_details_info_body.dart';
import 'package:store_app2/stripe_payment/stripe_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AuthView(authType: 1)),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await CacheData.remove();

                context.read<AuthCubit>().signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Profile', style: Style.textStyleBoldHeadLine),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PersonalDetailsInfoBody();
                            },
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text('Personal details'),
                        subtitle: Text(
                          'Email , Password , Full name ,Address',
                          style: Style.textStyle12grey,
                        ),
                      ),
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              Divider(color: Colors.grey.shade300),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AllOrders();
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('My Orders'),
                        subtitle: Text(
                          'Check your orders',
                          style: Style.textStyle12grey,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 17,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/change_password_bottom_sheet.dart';

class PersonalDetailsInfoBody extends StatefulWidget {
  const PersonalDetailsInfoBody({super.key});

  @override
  State<PersonalDetailsInfoBody> createState() =>
      _PersonalDetailsInfoBodyState();
}

class _PersonalDetailsInfoBodyState extends State<PersonalDetailsInfoBody> {
  @override
  void initState() {
    context.read<AuthCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final userData = context.read<AuthCubit>().userData;
          if (userData.isEmpty) {
            return Center(child: Text('Loading profile...'));
          }
          if (state is AuthSuccess && userData.isNotEmpty) {
            final cubit = context.read<AuthCubit>();
            final password = cubit.userData['password'];
            String hiddenPassword = '*';
            hiddenPassword =
                context.read<AuthCubit>().userData['googleAccount'] == true
                ? hiddenPassword * 10
                : hiddenPassword * password.length;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Profile', style: Style.textStyleBoldHeadLine),

                  Text('Personal Details', style: Style.textStyleBold16Black),
                  SizedBox(height: 35),

                  ListTile(
                    tileColor: Colors.white,
                    title: Text('Full name', style: Style.textStyle12grey),
                    subtitle: Text(userData['name']),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text('Email', style: Style.textStyle12grey),
                    subtitle: Text(userData['email']),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text('Address', style: Style.textStyle12grey),

                    subtitle: Text(userData['address']),
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Password', style: Style.textStyleBold24Black),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ChangePasswordBottomSheet();
                            },
                          );
                        },
                        child: Text('Change', style: Style.textStyle14grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text('Password', style: Style.textStyle12grey),

                    subtitle: Text(hiddenPassword),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

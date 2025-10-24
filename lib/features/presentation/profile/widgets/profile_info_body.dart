import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class ProfileInfoBody extends StatefulWidget {
  ProfileInfoBody({super.key});

  @override
  State<ProfileInfoBody> createState() => _ProfileInfoBodyState();
}

class _ProfileInfoBodyState extends State<ProfileInfoBody> {
  @override
  void initState() {
    context.read<AuthCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final cubit = context.read<AuthCubit>();
          final password = cubit.userData['password'];
          String hiddenPassword = '*';
          hiddenPassword =
              context.read<AuthCubit>().userData['googleAccount'] == true
              ? hiddenPassword * 10
              : hiddenPassword * password.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Profile', style: Style.textStyleBold30Black),
              SizedBox(height: 20),

              ListTile(
                tileColor: Colors.white,
                title: Text('Full name', style: Style.textStyle11grey),
                subtitle: Text(context.read<AuthCubit>().userData['name']),
              ),
              SizedBox(height: 20),
              ListTile(
                tileColor: Colors.white,
                leading: Text(hiddenPassword, style: Style.textStyle14grey),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart' show Style;
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class CardOrderDetails extends StatelessWidget {
  const CardOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().userData;
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userData['name'],
                  style: Style.textStyle16Black,
                  textAlign: TextAlign.left,
                ),
                InkWell(
                  child: Text('Change', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(userData['address'], style: Style.textStyle16Black),
          ],
        ),
      ),
    );
  }
}

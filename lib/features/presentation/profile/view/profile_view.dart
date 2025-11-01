import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/profile/widgets/personal_details_info_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Profile', style: Style.textStyleBoldHeadLine),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('My Orders'),
                    subtitle: Text(
                      'Check your orders',
                      style: Style.textStyle11grey,
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
            Divider(color: Colors.grey.shade300),
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
                        'Email,Password',
                        style: Style.textStyle11grey,
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
          ],
        ),
      ),
    );
  }
}

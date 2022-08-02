import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/inner_widget/profile_screen.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen(
      name: 'Mustafa Hamim',
      email: 'shimul6680@gmail.com',
      id: '0123456789',
    );
  }
}

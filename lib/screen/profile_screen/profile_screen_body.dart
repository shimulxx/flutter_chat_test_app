import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/controller/profile_screen_cubit.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/controller/profile_screen_state.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/inner_widget/profile_screen.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
      builder: (context, state){
        if(state.isLoading){
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
        else {
          final user = state.user!;
          return ProfileScreen(
            imageUrl: user.photoUrl!,
            name: user.displayName!,
            email: user.email,
            id: user.id,
        );}
      },

    );
  }
}

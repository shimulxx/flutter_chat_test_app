import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/core/constants.dart';
import 'package:flutter_chat_test_app/screen/login_screen/controller/login_cubit.dart';
import '../controller/login_state.dart';
import 'inner_widget/login_button.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Center(
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state){
          print('state condition :${state.isLoggedIn}');
          if(state.hasError) {
            print(state.errorMessage);
          }
          else if(state.isLoggedIn){
            Navigator.of(context).pushReplacementNamed(kChatListScreen);
          }
        },
        child: LoginButton(
          onPressed: cubit.onPressLogin,
        ),
      ),
    );
  }
}
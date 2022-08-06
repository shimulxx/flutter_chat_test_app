import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/details_screen.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/chat_list_body.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:flutter_chat_test_app/screen/login_screen/controller/login_cubit.dart';
import 'package:flutter_chat_test_app/screen/login_screen/inner_widget/login_screen_body.dart';
import 'package:flutter_chat_test_app/screen/login_screen/login_screen.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/controller/profile_screen_cubit.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/profile_screen_body.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'app_variable/sign_in_condition.dart';
import 'injection_work.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case kDefaultRoute:
      case kChatListScreen:
        if (isSignedIn) {
          return MaterialPageRoute(
            builder: (context) =>
                BlocProvider(
                  create: (context) => di<ChatListScreenCubit>()..loadData(),
                  child: const ChatListBody(),
                ),
          );
        }
        else{
          return MaterialPageRoute(
              builder: (context) =>
                  BlocProvider(
                    create: (context) => di<LoginCubit>(),
                    child: const LoginScreen(),
                  ),
          );
        }
      case kProfileScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => di<ProfileScreenCubit>()..loadData(),
              child: const ProfileScreenBody(),
            ));
      case kChatDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const ChatDetailsScreenBody());
      default:
        return null;
    }
  }
}

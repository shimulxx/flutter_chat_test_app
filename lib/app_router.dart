import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/details_screen.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/chat_list_body.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/profile_screen_body.dart';
import 'injection_work.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di<ChatListScreenCubit>()..loadData(),
            child: const ChatListBody(),
          ),
        );
      case kProfileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreenBody());
      case kChatDetailsScreen:
        return MaterialPageRoute(builder: (context) => const ChatDetailsScreenBody());
      default: return null;
    }
  }
}

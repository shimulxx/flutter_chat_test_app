import 'package:flutter_chat_test_app/app_router.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.I;

void registerAll(){
  _registerChatList();
  _registerAppRouter();
}

void _registerChatList(){
  di.registerFactory<ChatListScreenCubit>(() => ChatListScreenCubit());
}

void _registerAppRouter(){
  di.registerLazySingleton<AppRouter>(() => AppRouter());
}
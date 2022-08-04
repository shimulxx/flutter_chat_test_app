import 'package:flutter_chat_test_app/app_router.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/controller/alert_dialog_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.I;

void registerAllDependency(){
  _registerChatList();
  _registerAppRouter();
  _registerAlertDialog();
}

void _registerChatList(){
  di.registerFactory<ChatListScreenCubit>(() => ChatListScreenCubit());
}

void _registerAppRouter(){
  di.registerLazySingleton<AppRouter>(() => AppRouter());
}

void _registerAlertDialog(){
  di.registerFactory<AlertDialogCubit>(() => AlertDialogCubit());
}
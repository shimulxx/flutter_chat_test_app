import 'package:flutter_chat_test_app/api/login/repository/repository.dart';
import 'package:flutter_chat_test_app/app_router.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/controller/alert_dialog_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/login/use_cases/cases.dart';

final di = GetIt.I;

void registerAllDependency(){
  _registerChatList();
  _registerAppRouter();
  _registerAlertDialog();
  _registerLogin();
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

void _registerLogin(){
  di.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  di.registerLazySingleton<LoginRepository>(() => LoginRepositoryImp(googleSignIn: di()));
  di.registerLazySingleton<GoogleLoginUseCase>(() => GoogleLoginUseCaseImp(loginRepository: di()));
  di.registerLazySingleton<GoogleLogoutUseCase>(() => GoogleLogoutUseCaseImp(loginRepository: di()));
}
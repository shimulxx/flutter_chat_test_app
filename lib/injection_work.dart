import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_test_app/api/repository/repository.dart';
import 'package:flutter_chat_test_app/app_router.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/controller/alert_dialog_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:flutter_chat_test_app/screen/login_screen/controller/login_cubit.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/controller/profile_screen_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/use_cases/cases.dart';

final di = GetIt.I;

void registerAllDependency() async{
  _registerChatList();
  _registerAppRouter();
  _registerAlertDialog();
  _registerRepo();
  _registerProfile();
  _registerChatDetails();
  _registerLogin();
  await di.allReady();
}

void _registerChatList(){
  di.registerFactory<ChatListScreenCubit>(() => ChatListScreenCubit(
    googleLogoutUseCase: di(),
    getUserChatListStreamUseCase: di(),
  ));
  di.registerLazySingleton<SingleStreamUseCase>(() => SingleStreamUseCaseImp(repository: di()));
}

void _registerChatDetails(){
  di.registerLazySingleton<GetUserChatDetailsStreamUseCase>(() => GetUserChatDetailsStreamUseCaseImp(repository: di()));
  di.registerFactory<ChatRoomDetailsCubit>(() => ChatRoomDetailsCubit(
    getUserChatDetailsStreamUseCase: di(),
    chatSendUseCase: di(),
    updateDeliveryUseCase: di(),
  ));
  di.registerLazySingleton<GetUserStrUseCase>(() => GetUserStrUseCaseImp(repository: di()));
  di.registerLazySingleton<ChatSendUseCase>(() => ChatSendUseCaseImp(repository: di()));
  di.registerLazySingleton<UpdateDeliveryUseCase>(() => UpdateDeliveryUseCaseImp(repository: di()));
}

void _registerAppRouter(){
  di.registerLazySingleton<AppRouter>(() => AppRouter());
}

void _registerAlertDialog(){
  di.registerFactory<AlertDialogCubit>(() => AlertDialogCubit(
    alertDialogUserListUseCase: di(),
    chatRoomCreateUseCase: di(),
  ));
  di.registerLazySingleton<AlertDialogUserListUseCase>(() => AlertDialogUserListUseCaseImp(repository: di()));
}

void _registerLogin(){
  di.registerLazySingleton<GoogleLoginUseCase>(() => GoogleLoginUseCaseImp(repository: di()));
  di.registerLazySingleton<GoogleLogoutUseCase>(() => GoogleLogoutUseCaseImp(repository: di()));
  di.registerFactory<LoginCubit>(() => LoginCubit(googleLoginUseCase: di()));
}

void _registerRepo(){
  di.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  di.registerLazySingleton<Repository>(() => RepositoryImp(
    googleSignIn: di(),
    firebaseInstance: di(),
    fireStoreInstance: di(),
  ));
  di.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  di.registerLazySingleton<ChatRoomCreateUseCase>(() => ChatRoomCreateUseCaseImp(repository: di()));
  di.registerLazySingleton<GetUserChatListStreamUseCase>(() => GetUserChatListStreamUseCaseImp(repository: di()));
}

void _registerProfile(){
  di.registerFactory<ProfileScreenCubit>(() => ProfileScreenCubit(googleLoginUseCase: di()));
}
import 'package:firebase_auth/firebase_auth.dart';
import '../../../screen/alert_dialog/data_model/drop_down_data.dart';
import '../repository/repository.dart';

abstract class GoogleLoginUseCase{
  Future<User?> getUser();
}

class GoogleLoginUseCaseImp implements GoogleLoginUseCase{
  final Repository repository;
  const GoogleLoginUseCaseImp({required this.repository});

  @override
  Future<User?> getUser() {
    return repository.getUser();
  }
}

abstract class GoogleLogoutUseCase{
  Future<void> logout();
}

class GoogleLogoutUseCaseImp implements GoogleLogoutUseCase{
  final Repository repository;

  const GoogleLogoutUseCaseImp({required this.repository});

  @override
  Future<void> logout() {
    return repository.logout();
  }
}

abstract class AlertDialogUserListUseCase{
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog();
}

class AlertDialogUserListUseCaseImp implements AlertDialogUserListUseCase{
  final Repository repository;

  AlertDialogUserListUseCaseImp({required this.repository});

  @override
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog() {
    return repository.getUsrListForAlertDialog();
  }
}

abstract class ChatRoomCreateUseCase{
  Future<void> createChatRoomForCurrentUser(String targetUser);
}

class ChatRoomCreateUseCaseImp implements ChatRoomCreateUseCase{
  final Repository repository;
  ChatRoomCreateUseCaseImp({required this.repository});

  @override
  Future<void> createChatRoomForCurrentUser(String targetUser) {
    return repository.createChatRoomForCurrentUser(targetUser);
  }
}
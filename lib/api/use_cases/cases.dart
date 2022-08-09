import 'package:firebase_auth/firebase_auth.dart';
import '../../../screen/alert_dialog/data_model/drop_down_data.dart';
import '../../screen/chat_details_screen/data_model/chat_detail_item_data.dart';
import '../../screen/chat_list_screen/data_model/chat_item_data.dart';
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

abstract class GetUserChatListStreamUseCase{
  Stream<List<ChatItemData>> getStreamChatItemData();
}

class GetUserChatListStreamUseCaseImp implements GetUserChatListStreamUseCase{
  final Repository repository;

  GetUserChatListStreamUseCaseImp({required this.repository});

  @override
  Stream<List<ChatItemData>> getStreamChatItemData() {
    return repository.getStreamChatItemData();
  }
}

abstract class GetUserChatDetailsStreamUseCase{
  Stream<List<ChatDetailItemData>> getStreamChatDetailsItemData({required String chatRoomId});
}

class GetUserChatDetailsStreamUseCaseImp implements GetUserChatDetailsStreamUseCase{
  final Repository repository;

  GetUserChatDetailsStreamUseCaseImp({required this.repository});

  @override
  Stream<List<ChatDetailItemData>> getStreamChatDetailsItemData({required String chatRoomId}) {
    return repository.getStreamChatDetailsItemData(chatRoomId: chatRoomId);
  }
}

abstract class GetUserStrUseCase{
  String? get userString;
}

class GetUserStrUseCaseImp implements GetUserStrUseCase{
  final Repository repository;

  GetUserStrUseCaseImp({required this.repository});

  @override
  String? get userString {
    return repository.getCurrentUserStr();
  }
}

abstract class ChatSendUseCase{
  Future<void> sendCurrentData({required ChatDetailItemData curData, required String chatRoomId});
}

class ChatSendUseCaseImp implements ChatSendUseCase{
  final Repository repository;

  ChatSendUseCaseImp({required this.repository});

  @override
  Future<void> sendCurrentData({required ChatDetailItemData curData, required String chatRoomId}) {
    return repository.sendCurrentData(curData: curData, chatRoomId: chatRoomId);
  }
}

abstract class UpdateDeliveryUseCase{
  Future<void> updateDelivery({required List<String> updateList, required String chatRoomId});
}

class UpdateDeliveryUseCaseImp implements UpdateDeliveryUseCase{

  final Repository repository;

  UpdateDeliveryUseCaseImp({required this.repository});

  @override
  Future<void> updateDelivery({required List<String> updateList, required String chatRoomId}) {
    return repository.updateDelivery(updateList: updateList, chatRoomId: chatRoomId);
  }

}

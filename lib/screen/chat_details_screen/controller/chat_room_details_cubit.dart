import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_state.dart';
import '../../../api/use_cases/cases.dart';
import '../data_model/chat_detail_item_data.dart';

class ChatRoomDetailsCubit extends Cubit<ChatRoomDetailsState>{
  final GetUserChatDetailsStreamUseCase getUserChatDetailsStreamUseCase;
  final ChatSendUseCase chatSendUseCase;
  final UpdateDeliveryUseCase updateDeliveryUseCase;
  late final String curRoomId;
  late final String curUserId;

  ChatRoomDetailsCubit({
    required this.getUserChatDetailsStreamUseCase,
    required this.chatSendUseCase,
    required this.updateDeliveryUseCase,
  }) : super(const ChatRoomDetailsState());

  void updateDelivery(List<ChatDetailItemData> detailData){
    final list = <String>[];
    for(var i = detailData.length - 1; i >= 0; --i){
      final curItem = detailData[i];
      if(curItem.userId != curUserId){
        if(curItem.isDelivered) { break; }
        else{ list.add(curItem.epocTime); }
      }
    }
    updateDeliveryUseCase.updateDelivery(updateList: list, chatRoomId: curRoomId);
  }

  void loadData({required String roomId, required String uId}){
    curRoomId = roomId;
    curUserId = uId;
    final streamList = getUserChatDetailsStreamUseCase.getStreamChatDetailsItemData(chatRoomId: curRoomId);
    emit(state.copyWith(roomId: roomId, streamList: streamList));
  }

  void onChangeText({required ChatDetailItemData data}){
    chatSendUseCase.sendCurrentData(curData: data, chatRoomId: curRoomId);
  }

}
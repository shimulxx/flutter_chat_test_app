import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_state.dart';
import '../../../api/use_cases/cases.dart';

class ChatRoomDetailsCubit extends Cubit<ChatRoomDetailsState>{
  final GetUserChatDetailsStreamUseCase getUserChatDetailsStreamUseCase;

  ChatRoomDetailsCubit({required this.getUserChatDetailsStreamUseCase})
      : super(const ChatRoomDetailsState());

  void loadData({required String roomId}){
    emit(state.copyWith(roomId: roomId));
  }

}
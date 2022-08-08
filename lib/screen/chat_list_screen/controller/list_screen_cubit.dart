import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/use_cases/cases.dart';
import '../../../core/constants.dart';
import '../data_model/chat_item_data.dart';
import 'list_screen_state.dart';

class ChatListScreenCubit extends Cubit<ChatListScreenState>{
  final GoogleLogoutUseCase googleLogoutUseCase;
  final GetUserChatListStreamUseCase getUserChatListStreamUseCase;

  ChatListScreenCubit({
    required this.googleLogoutUseCase,
    required this.getUserChatListStreamUseCase,
  }) : super(const ChatListScreenState());

  void onChangeSearchKey(String searchKey) => emit(state.copyWith(searchKey: searchKey));

  void loadData(){
    emit(state.copyWith(streamList: getUserChatListStreamUseCase.getStreamChatItemData()));
  }

  Future<void> logout() async{
   await googleLogoutUseCase.logout();
  }

}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/use_cases/cases.dart';
import '../../../core/constants.dart';
import '../data_model/chat_item_data.dart';
import 'list_screen_state.dart';

class ChatListScreenCubit extends Cubit<ChatListScreenState>{
  final GoogleLogoutUseCase googleLogoutUseCase;
  ChatListScreenCubit({required this.googleLogoutUseCase}) : super(const ChatListScreenState());

  void onChangeSearchKey(String searchKey) => emit(state.copyWith(searchKey: searchKey));

  void loadData(){
    final list = <ChatItemData>[];
    for(var i = 1; i <= 20; ++i){
      list.add(ChatItemData(
        imageUrl: kAvatarDefaultPhotoUrl,
        name: i & 1 == 1 ? 'Faruq New' : 'Shimul Ahmed',
        isDelivered: (i & 1 == 1),
        lastTime: '7:22 pm',
        lastChat: 'Rana Vai',
      ));
    }
    emit(state.copyWith(list: list));
  }

  Future<void> logout() async{
   await googleLogoutUseCase.logout();
  }

}
import 'package:equatable/equatable.dart';
import '../data_model/chat_detail_item_data.dart';

class ChatRoomDetailsState extends Equatable{
  final Stream<List<ChatDetailItemData>>? streamList;
  const ChatRoomDetailsState({this.streamList});

  ChatRoomDetailsState copyWith({
    Stream<List<ChatDetailItemData>>? streamList,
    String? roomId,
  }){
    return ChatRoomDetailsState(
      streamList: streamList ?? this.streamList,
    );
  }

  @override
  List<Object?> get props => [streamList];

}
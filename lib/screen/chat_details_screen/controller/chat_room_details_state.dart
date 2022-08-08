import 'package:equatable/equatable.dart';
import '../data_model/chat_detail_item_data.dart';

class ChatRoomDetailsState extends Equatable{
  final Stream<List<ChatDetailItemData>>? streamList;
  final String roomId;

  const ChatRoomDetailsState({this.streamList, this.roomId = ''});

  ChatRoomDetailsState copyWith({
    Stream<List<ChatDetailItemData>>? streamList,
    String? roomId,
  }){
    return ChatRoomDetailsState(
      streamList: streamList ?? this.streamList,
      roomId: roomId ?? this.roomId,
    );
  }

  @override
  List<Object?> get props => [streamList, roomId];

}
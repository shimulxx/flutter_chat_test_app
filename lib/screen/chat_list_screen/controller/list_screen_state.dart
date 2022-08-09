import 'package:equatable/equatable.dart';

import '../data_model/chat_item_data.dart';

class ChatListScreenState extends Equatable{
  final String searchKey;
  final Stream<List<ChatItemData>>? streamList;
  const ChatListScreenState({
    this.searchKey = '',
    this.streamList,
  });

  ChatListScreenState copyWith({
    String? searchKey,
    Stream<List<ChatItemData>>? streamList,
  }){
    return ChatListScreenState(
      searchKey: searchKey ?? this.searchKey,
      streamList: streamList ?? this.streamList,
    );
  }

  @override
  List<Object?> get props => [searchKey, streamList];


}
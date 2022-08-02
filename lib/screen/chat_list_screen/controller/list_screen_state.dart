import 'package:equatable/equatable.dart';

import '../data_model/chat_item_data.dart';

class ChatListScreenState extends Equatable{
  final String searchKey;
  final List<ChatItemData> list;
  const ChatListScreenState({
    this.searchKey = '',
    this.list = const [],
  });

  ChatListScreenState copyWith({
    String? searchKey,
    List<ChatItemData>? list
  }){
    return ChatListScreenState(
      searchKey: searchKey ?? this.searchKey,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [searchKey, list];


}
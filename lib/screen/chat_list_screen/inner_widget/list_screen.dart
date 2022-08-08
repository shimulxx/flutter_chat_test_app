import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/data_model/chat_item_data.dart';
import '../../../core/constants.dart';
import 'inner_widget/list_item.dart';
import 'inner_widget/search_text_field.dart';

extension on String {
  bool containsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({
    Key? key,
    required this.list,
    required this.searchKey,
  }) : super(key: key);

  final List<ChatItemData> list;
  final String searchKey;

  @override
  Widget build(BuildContext context) {
    final newGeneratedListWithKey = <ChatItemData>[];
    for (var element in list) {
      if(element.name.containsIgnoreCase(searchKey)) { newGeneratedListWithKey.add(element); }
    }
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: newGeneratedListWithKey.length,
              itemBuilder: (context, index){
                final curItem = newGeneratedListWithKey[index];
                return ChatListItem(
                  onPressed: (){
                    Navigator.of(context).pushNamed(kChatDetailsScreen,
                        arguments: [curItem.chatRoomId, curItem.name, curItem.imageUrl]);
                  },
                  imageUrl: curItem.imageUrl,
                  name: curItem.name,
                  lastChat: curItem.lastChat,
                  lastTime: curItem.lastTime,
                  isDelivered: curItem.isDelivered,
                  highLightKey: searchKey,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


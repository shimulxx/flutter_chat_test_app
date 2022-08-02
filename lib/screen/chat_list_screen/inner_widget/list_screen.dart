import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/data_model/chat_item_data.dart';
import '../../../app_constants/app_constants.dart';
import 'inner_widget/list_item.dart';
import 'inner_widget/search_text_field.dart';


extension on String {
  bool containsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({
    Key? key,
    required this.list,
    required this.onPressAddButton,
    required this.searchKey,
    required this.onChangeKey,
  }) : super(key: key);

  final Function() onPressAddButton;
  final List<ChatItemData> list;
  final String searchKey;
  final Function(String) onChangeKey;

  @override
  Widget build(BuildContext context) {
    final newGeneratedListWithKey = <ChatItemData>[];
    for (var element in list) {
      if(element.name.containsIgnoreCase(searchKey)) { newGeneratedListWithKey.add(element); }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Chat List Screen'),),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        splashColor: Theme.of(context).splashColor,
        backgroundColor: const Color(0xff141414), //Theme.of(context).backgroundColor,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: onPressAddButton,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16,),
          SearchTextField(onTextChanged: onChangeKey),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: newGeneratedListWithKey.length,
              itemBuilder: (context, index){
                final curItem = newGeneratedListWithKey[index];
                return ChatListItem(
                  onPressed: (){
                    print('clicked');
                  },
                  imageUrl: kAvatarDefaultPhotoUrl,
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


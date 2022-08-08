import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/core/constants.dart';
import 'chat_text_field.dart';
import 'data_model/chat_detail_item_data.dart';
import 'inner_widget/app_bar.dart';
import 'inner_widget/chat_details_screen_list.dart';
import 'inner_widget/inner_widget/chat_details_list_item.dart';

class ChatDetailsScreenBody extends StatelessWidget {
  const ChatDetailsScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = <ChatDetailItemData>[];
    for(var i = 1; i <= 20; ++i){
      list.add(ChatDetailItemData(
        chatText: 'The name of our country is Bangladesh. This is a very big country. But this is a very beautiful country.',
        isDelivered: i & 1 == 0,
        sendTime: '5:25 PM',
        userId: i & 1 == 1 ? '123' : '456',
      ));
    }
    return Scaffold(
      appBar: const AppBarChatDetailsScreen(
        name: 'Mustafa Hamims',
        imageUrl: kAvatarDefaultPhotoUrl,
      ),
      body: Column(
        children: [
          ChatDetailsScreenListBody(list: list, curUserId: '123'),
          const SizedBox(height: 5),
          const ChatTextField(onTextSend: print),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}










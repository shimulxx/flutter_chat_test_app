import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';
import 'chat_text_field.dart';
import 'inner_widget/chat_details_screen_list.dart';
import 'inner_widget/inner_widget/chat_details_list_item.dart';

class ChatDetailsScreenBody extends StatelessWidget {
  const ChatDetailsScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = <ChatDetailsListItem>[];
    for(var i = 1; i <= 20; ++i){
      list.add(ChatDetailsListItem(
        chatText: 'The name of our country is Bangladesh. This is a very big country. But this is a very beautiful country.',
        isDelivered: i & 1 == 0,
        sendTime: '5:25 PM',
        self: i & 1 == 1,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 60,
        titleSpacing: 0,
        title: Row(
          children: [
            CachedNetworkImage(
              height: 40,
              width: 40,
              imageUrl: kAvatarDefaultPhotoUrl,
              placeholder: (c, s) => const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
            ),
            const SizedBox(width: 10),
            Text('Mustafa Hamim')
          ],
        ),
      ),
      body: Column(
        children: [
          ChatDetailsScreenListBody(list: list),
          const SizedBox(height: 5),
          const ChatTextField(onTextSend: print),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}








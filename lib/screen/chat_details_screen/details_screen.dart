import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/core/constants.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_state.dart';
import 'chat_text_field.dart';
import 'data_model/chat_detail_item_data.dart';
import 'inner_widget/app_bar.dart';
import 'inner_widget/chat_details_screen_list.dart';
import 'inner_widget/inner_widget/chat_details_list_item.dart';

class ChatDetailsScreenBody extends StatelessWidget {
  const ChatDetailsScreenBody({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.curUserId,
  }) : super(key: key);

  final String name, imageUrl, curUserId;

  @override
  Widget build(BuildContext context) {
    final list = <ChatDetailItemData>[];
    for(var i = 1; i <= 20; ++i){
      list.add(ChatDetailItemData(
        chatText: 'The name of our country is Bangladesh. This is a very big country. But this is a very beautiful country.',
        isDelivered: i & 1 == 1,
        sendTime: '5:25 PM',
        userId: i & 1 == 1 ? 123.toString() : curUserId,
      ));
    }
    return Scaffold(
      appBar: AppBarChatDetailsScreen(
        name: name,
        imageUrl: imageUrl,
      ),
      body: Column(
        children: [
          BlocBuilder<ChatRoomDetailsCubit, ChatRoomDetailsState>(
            builder: (context, state) => ChatDetailsScreenListBody(list: list, curUserId: curUserId),
          ),
          const SizedBox(height: 5),
          const ChatTextField(onTextSend: print),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}










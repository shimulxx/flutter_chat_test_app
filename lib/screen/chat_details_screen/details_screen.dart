import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_details_screen/controller/chat_room_details_state.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../date_time/date_time_use_cases.dart';
import '../../injection_work.dart';
import 'chat_text_field.dart';
import 'data_model/chat_detail_item_data.dart';
import 'inner_widget/app_bar.dart';
import 'inner_widget/chat_details_screen_list.dart';

class ChatDetailsScreenBody extends StatelessWidget {
  const ChatDetailsScreenBody({
    Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  final String name, imageUrl;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatRoomDetailsCubit>();
    return Scaffold(
      appBar: AppBarChatDetailsScreen(name: name, imageUrl: imageUrl),
      body: Column(
        children: [
          BlocBuilder<ChatRoomDetailsCubit, ChatRoomDetailsState>(
            builder: (context, state){
              return StreamBuilder<List<ChatDetailItemData>>(
                stream: state.streamList,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      final curList = snapshot.data!;
                      bloc.updateDelivery(curList);
                      return ChatDetailsScreenListBody(list: curList, curUserId: bloc.curUserId);
                    }
                    else {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    }
                  }
              );
            }
          ),
          const SizedBox(height: 5),
          ChatTextField(
            onTextSend: (value){
              final curData = ChatDetailItemData(
                chatText: value,
                isDelivered: false,
                sendTime: di<AppDateTimeFormatUseCase>().curTime(),
                userId: bloc.curUserId,
              );
              bloc.onChangeText(data: curData);
            },
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}










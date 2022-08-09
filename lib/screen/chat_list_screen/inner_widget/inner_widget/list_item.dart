import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/injection_work.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../../api/use_cases/cases.dart';
import '../../../../core/constants.dart';
import '../../../chat_details_screen/data_model/chat_detail_item_data.dart';
import 'inner_widget/delivery_widget.dart';

class ChatListItem extends StatelessWidget {
  ChatListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.onPressed,
    required this.highLightKey,
    required this.chatRoomId,
  }) : super(key: key);

  final String name, imageUrl, chatRoomId;
  final Function() onPressed;
  final String highLightKey;
  final SingleStreamUseCase singleStreamUseCase = di<SingleStreamUseCase>();
  final GetUserStrUseCase getUserStrUseCase = di<GetUserStrUseCase>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 50,
                      width: 50,
                      errorWidget: (c, u, e) => Image.asset(kDefaultLocalAvatarPhoto, height: 50, width: 50,),
                      placeholder: (c, s) => const Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator()),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubstringHighlight(
                          text: name,
                          term: highLightKey,
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textStyleHighlight: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
                        ),
                        const SizedBox(height: 5),
                        StreamBuilder<ChatDetailItemData>(
                          stream: singleStreamUseCase.getSingleStream(chatRoomId: chatRoomId),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              final curData = snapshot.data!;
                              if(curData.userId.isEmpty){ return const Text('No data found!'); }
                              else{
                                return DeliveryWidget(
                                  isDelivered: curData.isDelivered,
                                  lastChat: curData.chatText,
                                  isSelf: curData.userId == getUserStrUseCase.userString,
                                );
                              }
                            }
                            else{ return const Text('No data'); }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<ChatDetailItemData>(
                stream: singleStreamUseCase.getSingleStream(chatRoomId: chatRoomId),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    final curData = snapshot.data!;
                    if(curData.userId.isEmpty){ return const Text('No data found!'); }
                    else{ return Text(curData.sendTime); }
                  }
                  else{ return const Text('No data'); }
                }
            )
          ],
        ),
      ),
    );
  }
}


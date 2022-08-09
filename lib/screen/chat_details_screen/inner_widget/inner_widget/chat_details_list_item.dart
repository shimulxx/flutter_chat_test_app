import 'package:flutter/material.dart';

class ChatDetailsListItem extends StatelessWidget {
  const ChatDetailsListItem({
    Key? key,
    required this.chatText,
    required this.isDelivered,
    required this.sendTime,
    required this.self,
  }) : super(key: key);

  final String chatText, sendTime;
  final bool isDelivered, self;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 5;
    return Material(
      elevation: 5,
      child: Container(
        margin: !self
            ? EdgeInsets.only(left: 10, right: width, top: 8)
            : EdgeInsets.only(left: width, right: 10, top: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: self ? Colors.red.withOpacity(0.7) : Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chatText, textAlign: TextAlign.justify),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(sendTime),
                if(self) Row(
                  children: [
                    const SizedBox(width: 10),
                    for(var i = 1; i <= (isDelivered ? 2 : 1); ++i) Transform.scale(scale: 2, child: const Icon(Icons.check, size: 8)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
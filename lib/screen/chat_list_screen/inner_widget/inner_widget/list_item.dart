import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../../app_constants/app_constants.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.isDelivered,
    required this.lastChat,
    required this.lastTime,
    required this.onPressed,
    required this.highLightKey,
  }) : super(key: key);

  final String name, imageUrl, lastChat, lastTime;
  final bool isDelivered;
  final Function() onPressed;
  final String highLightKey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: kAvatarDefaultPhotoUrl,
                  height: 50,
                  width: 50,
                  errorWidget: (c, u, e) => Image.asset(kDefaultLocalAvatarPhoto, height: 50, width: 50,),
                  placeholder: (c, s) => const Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator()),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubstringHighlight(
                      text: name,
                      term: highLightKey,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textStyleHighlight: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        for(var i = 1; i <= (isDelivered ? 2 : 1); ++i) Transform.scale(scale: 2, child: const Icon(Icons.check, size: 6, )),
                        const SizedBox(width: 5,),
                        Text(lastChat, style: const TextStyle(fontSize: 11),)
                      ],
                    )
                  ],
                )
              ],
            ),
            Text(lastTime)
          ],
        ),
      ),
    );
  }
}
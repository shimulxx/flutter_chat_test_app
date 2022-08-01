import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.dark(),),
      home: const ChatListScreen(),
    );
  }
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat List Screen'),),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        splashColor: Theme.of(context).splashColor,
        backgroundColor: const Color(0xff141414), //Theme.of(context).backgroundColor,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: (){},
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return ChatListItem(
            onPressed: (){
              print('clicked');
            },
            imageUrl: kAvatarDefaultPhotoUrl,
            name: 'Faruq New',
            lastChat: 'Rana Vai',
            lastTime: '7:22 PM',
            isDelivered: true,
          );
        },

      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.isDelivered,
    required this.lastChat,
    required this.lastTime,
    required this.onPressed,
  }) : super(key: key);

  final String name, imageUrl, lastChat, lastTime;
  final bool isDelivered;
  final Function() onPressed;

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
                  errorWidget: (c, u, e) => Image.asset(imageUrl, height: 50, width: 50,),
                  placeholder: (c, s) => const Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator()),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
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


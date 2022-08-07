import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppBarChatDetailsScreen extends StatelessWidget with PreferredSizeWidget {
  const AppBarChatDetailsScreen({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  final String name, imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //toolbarHeight: 60,
      titleSpacing: 0,
      title: Row(
        children: [
          CachedNetworkImage(
            height: 40,
            width: 40,
            imageUrl: imageUrl,
            placeholder: (c, s) => const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
          ),
          const SizedBox(width: 10),
          Text(name),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
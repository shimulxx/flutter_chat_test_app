import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatListThreeDotIcon extends StatelessWidget {
  const ChatListThreeDotIcon({
    Key? key,
    required this.onChangeValue,
  }) : super(key: key);

  final Function(int?) onChangeValue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: SvgPicture.asset('assets/images/svgs/three_dots.svg', color: Colors.white, height: 16),
      itemBuilder: (v){
        return <PopupMenuEntry<int>>[
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(Icons.account_circle),
                SizedBox(width: 5),
                Text('Profile')
              ],
            ),
            value: 1,
          ),
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(Icons.logout),
                SizedBox(width: 5),
                Text('Logout')
              ],
            ),
            value: 2,
          ),
        ];
      },
      onSelected: onChangeValue,
    );
  }
}
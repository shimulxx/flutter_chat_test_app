import 'package:flutter/material.dart';

class DeliveryWidget extends StatelessWidget {
  const DeliveryWidget({
    Key? key,
    required this.isDelivered,
    required this.lastChat,
    required this.isSelf,
  }) : super(key: key);

  final bool isDelivered;
  final String lastChat;
  final bool isSelf;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 13,
      child: Row(
        children: [
          if(isSelf)
            for(var i = 1; i <= (isDelivered ? 2 : 1); ++i)
              Transform.scale(scale: 2, child: Icon(Icons.check, size: 9, color: isDelivered ? Colors.cyan : null)),
          if(isSelf) const SizedBox(width: 10),
          Expanded(
            child: Text(
              lastChat,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
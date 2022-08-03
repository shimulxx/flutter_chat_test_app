import 'package:flutter/material.dart';
import 'inner_widget/chat_details_list_item.dart';

class ChatDetailsScreenListBody extends StatefulWidget {
  const ChatDetailsScreenListBody({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<ChatDetailsListItem> list;

  @override
  State<ChatDetailsScreenListBody> createState() => _ChatDetailsScreenListBodyState();
}

class _ChatDetailsScreenListBodyState extends State<ChatDetailsScreenListBody> {
  final _controller = ScrollController();
  late List<ChatDetailsListItem> _innerList = widget.list;

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollDown());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatDetailsScreenListBody oldWidget) {
    _innerList = widget.list;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: _controller,
        itemCount: _innerList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final curItem = _innerList[index];
          return ChatDetailsListItem(
            chatText: curItem.chatText,
            isDelivered: curItem.isDelivered,
            sendTime: curItem.sendTime,
            self: curItem.self,
          );
        },
      ),
    );
  }
}

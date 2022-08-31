import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../data_model/chat_detail_item_data.dart';
import 'inner_widget/chat_details_list_item.dart';

class ChatDetailsScreenListBody extends StatefulWidget {
  const ChatDetailsScreenListBody({
    Key? key,
    required this.list,
    required this.curUserId,
  }) : super(key: key);

  final List<ChatDetailItemData> list;
  final String curUserId;

  @override
  State<ChatDetailsScreenListBody> createState() => _ChatDetailsScreenListBodyState();
}

class _ChatDetailsScreenListBodyState extends State<ChatDetailsScreenListBody> {
  final _controller = ScrollController();
  late List<ChatDetailItemData> _innerList = widget.list;
  late var _innerUserId = widget.curUserId;
  late final keyboardVisibilityController = KeyboardVisibilityController();
  late StreamSubscription<bool> _keyboardSubscription;
  var _disposeIsCalled = false;

  void _scrollDownWork() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  Future<void> _scrollDown({bool isFromDidUpdate = false}) async{
    if(isFromDidUpdate){
      await Future.delayed(const Duration(milliseconds: 300));
    }
    WidgetsBinding.instance?.addPostFrameCallback((_){
      if(!_disposeIsCalled) _scrollDownWork();
    });
  }

  @override
  void initState() {
    _keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
        //print('Keyboard visibility update. Is visible: $visible');
        _scrollDown(isFromDidUpdate: true);
    });
    _scrollDown();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatDetailsScreenListBody oldWidget){
    //print('did update called');
    _innerList = widget.list;
    _innerUserId = widget.curUserId;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose(){
    _disposeIsCalled = true;
    _keyboardSubscription.cancel();
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
            self: _innerUserId == curItem.userId,
          );
        },
      ),
    );
  }
}

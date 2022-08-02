import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/list_screen_cubit.dart';
import 'controller/list_screen_state.dart';
import 'inner_widget/list_screen.dart';

class ChatListBody extends StatelessWidget {
  const ChatListBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatListScreenCubit>();
    return BlocBuilder<ChatListScreenCubit, ChatListScreenState>(
        builder: (context, state) {
          return ChatListScreen(
            onPressAddButton: (){},
            list: state.list,
            searchKey: state.searchKey,
            onChangeKey: bloc.onChangeSearchKey,
          );
        }
    );
  }
}
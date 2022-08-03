import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/list_screen_cubit.dart';
import 'controller/list_screen_state.dart';
import 'inner_widget/inner_widget/search_text_field.dart';
import 'inner_widget/list_screen.dart';

class ChatListBody extends StatelessWidget {
  const ChatListBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatListScreenCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Chat List Screen')),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        splashColor: Theme.of(context).splashColor,
        backgroundColor: const Color(0xff141414),
        //Theme.of(context).backgroundColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          SearchTextField(onTextChanged: bloc.onChangeSearchKey),
          const SizedBox(height: 10),
          BlocBuilder<ChatListScreenCubit, ChatListScreenState>(
            builder: (context, state) {
              return ChatListScreen(
                list: state.list,
                searchKey: state.searchKey,
              );
            },
          ),
        ],
      ),
    );
  }
}

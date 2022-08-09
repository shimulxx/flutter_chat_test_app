import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/core/constants.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/inner_widget/app_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app_variable/sign_in_condition.dart';
import '../alert_dialog/data_model/drop_down_data.dart';
import '../alert_dialog/dialog_body.dart';
import 'controller/list_screen_cubit.dart';
import 'controller/list_screen_state.dart';
import 'data_model/chat_item_data.dart';
import 'inner_widget/inner_widget/search_text_field.dart';
import 'inner_widget/list_screen.dart';
import 'inner_widget/three_dot_widget.dart';

class ChatListBody extends StatelessWidget {
  const ChatListBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatListScreenCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List Screen'),
        actions: [
          ChatListThreeDotIcon(
            onChangeValue: (value) async{
              if(value == 1){ Navigator.of(context).pushNamed(kProfileScreen); }
              else{
                await bloc.logout();
                Navigator.of(context).pushNamed(kDefaultRoute);
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        splashColor: Theme.of(context).splashColor,
        backgroundColor: const Color(0xff141414),
        //Theme.of(context).backgroundColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () { AlertDialogWork.showAddAlertDialog(context); },
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          SearchTextField(onTextChanged: bloc.onChangeSearchKey),
          const SizedBox(height: 10),
          BlocBuilder<ChatListScreenCubit, ChatListScreenState>(
            builder: (context, state) {
              return StreamBuilder<List<ChatItemData>>(
                stream: state.streamList,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final curList = snapshot.data!;
                    return ChatListScreen(
                      list: curList,
                      searchKey: state.searchKey,
                    );
                  }
                  else {
                    return const Expanded(child: Center(child: CircularProgressIndicator()));
                  }
                }
              );
            },
          ),
        ],
      ),
    );
  }
}





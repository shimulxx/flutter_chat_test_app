import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/inner_widget/app_dialog.dart';
import '../alert_dialog/data_model/drop_down_data.dart';
import '../alert_dialog/dialog_body.dart';
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
    print('list generated');
    final items = <AlertDialogDropDownData>[];
    for(var i = 1; i <= 5; ++i) {
      items.add(AlertDialogDropDownData(id: i.toString(), name: 'Shimul$i', imageUrl: kAvatarDefaultPhotoUrl));
    }
    // print(items[0].hashCode);
    // print(items[1].hashCode);
    // print(items[0] == items[0]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List Screen'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed(kProfileScreen);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.account_circle, size: 25),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(kProfileScreen);
            },
            child: AbsorbPointer(
              child: Row(
                children: const[
                  Center(child: Text('Profile', textAlign: TextAlign.center,)),
                  SizedBox(width: 15,)
                ],
              ),
            ),
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
      // body: Center(
      //   child: AddAlertDialogBody(items: items),
      // ),
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



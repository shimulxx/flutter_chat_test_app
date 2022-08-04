import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/controller/alert_dialog_cubit.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/controller/alert_dialog_state.dart';
import 'inner_widget/drop_down.dart';

class AddAlertDialogBody extends StatelessWidget {
  const AddAlertDialogBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlertDialogCubit>();
    return BlocBuilder<AlertDialogCubit, AlertDialogState>(
      builder: (context, state) {
        if (state.isLoading) { return const Center(child: CircularProgressIndicator()); }
        else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppDialogDropDown(
                items: state.dropDownDataList,
                onChangeValue: bloc.onValueChanged,
              ),
              IconButton(
                onPressed: () async{
                  await bloc.onPressAdd(state.selectedId);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
              )
            ],
          );
        }
      },
    );
  }
}

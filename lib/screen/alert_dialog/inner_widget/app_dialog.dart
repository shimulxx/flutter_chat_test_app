import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/screen/alert_dialog/controller/alert_dialog_cubit.dart';
import '../../../injection_work.dart';
import '../dialog_body.dart';

class AlertDialogWork{
  static void _removeAlertDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showAddAlertDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (newContext){
          return BlocProvider.value(
            value: di<AlertDialogCubit>()..loadData(),
            child: AlertDialog(
              title: const Text('Add User', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddAlertDialogBody()
                ],
              ),
            )
          );
        }
    );
  }
}
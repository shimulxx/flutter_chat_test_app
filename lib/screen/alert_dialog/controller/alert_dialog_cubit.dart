import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/core/constants.dart';
import '../../../api/use_cases/cases.dart';
import '../data_model/drop_down_data.dart';
import 'alert_dialog_state.dart';

class AlertDialogCubit extends Cubit<AlertDialogState>{
  final AlertDialogUserListUseCase alertDialogUserListUseCase;
  final ChatRoomCreateUseCase chatRoomCreateUseCase;
  AlertDialogCubit({required this.alertDialogUserListUseCase, required this.chatRoomCreateUseCase}) : super(const AlertDialogState(isLoading: true));

  void loadData() async{
    emit(state.copyWith(isLoading: true));
    try{
      final list = await alertDialogUserListUseCase.getUsrListForAlertDialog();
      emit(state.copyWith(isLoading: false, dropDownDataList: list, selectedId: list.isEmpty ? '' : list[0].id));
    }
    catch(e){
      final errorMessage = e.toString();
      emit(state.copyWith(isLoading: false, hasError: true, errorMessage: errorMessage));
    }
  }

  Future<void> onPressAdd(String targetUser) async{
      await chatRoomCreateUseCase.createChatRoomForCurrentUser(targetUser);
  }
  
  void onValueChanged(String value){
    emit(state.copyWith(selectedId: value));
  }

}
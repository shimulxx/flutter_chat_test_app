import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/core/constants.dart';
import '../../../api/login/use_cases/cases.dart';
import '../data_model/drop_down_data.dart';
import 'alert_dialog_state.dart';

class AlertDialogCubit extends Cubit<AlertDialogState>{
  final AlertDialogUserListUseCase useCase;
  AlertDialogCubit({required this.useCase}) : super(const AlertDialogState(isLoading: true));

  void loadData() async{
    emit(state.copyWith(isLoading: true));
    try{
      final list = await useCase.getUsrListForAlertDialog(userId: '');
      emit(state.copyWith(isLoading: false, dropDownDataList: list, selectedId: list.isEmpty ? '' : list[0].id));
    }
    catch(e){
      final errorMessage = e.toString();
      emit(state.copyWith(isLoading: false, hasError: true, errorMessage: errorMessage));
    }
  }

  Future<void> onPressAdd(String value) async{
      print(value);
  }
  
  void onValueChanged(String value){
    emit(state.copyWith(selectedId: value));
  }

}
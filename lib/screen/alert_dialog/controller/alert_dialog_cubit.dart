import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';
import '../data_model/drop_down_data.dart';
import 'alert_dialog_state.dart';

class AlertDialogCubit extends Cubit<AlertDialogState>{
  AlertDialogCubit() : super(const AlertDialogState(isLoading: false));

  void loadData(){
    final list = <AlertDialogDropDownData>[];
    list.add(const AlertDialogDropDownData(id: '1', name: 'Shimul', imageUrl: kAvatarDefaultPhotoUrl));
    list.add(const AlertDialogDropDownData(id: '2', name: 'Shimul', imageUrl: kAvatarDefaultPhotoUrl));
    emit(state.copyWith(dropDownDataList: list, selectedId: list[0].id));
  }

  Future<void> onPressAdd(String value) async{
      print(value);
  }
  
  void onValueChanged(String value){
    emit(state.copyWith(selectedId: value));
  }

}
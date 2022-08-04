import 'package:equatable/equatable.dart';
import '../data_model/drop_down_data.dart';

class AlertDialogState extends Equatable{
  final List<AlertDialogDropDownData> dropDownDataList;
  final bool isLoading;
  final String selectedId;

  const AlertDialogState({
    this.dropDownDataList = const [],
    required this.isLoading,
    this.selectedId = '',
  });

  AlertDialogState copyWith({
    List<AlertDialogDropDownData>? dropDownDataList,
    bool? isLoading,
    String? selectedId,
  }){
    return AlertDialogState(
      isLoading: isLoading ?? this.isLoading,
      dropDownDataList: dropDownDataList ?? this.dropDownDataList,
      selectedId: selectedId ?? this.selectedId,
    );
  }

  @override
  List<Object?> get props => [isLoading, dropDownDataList, selectedId];

}
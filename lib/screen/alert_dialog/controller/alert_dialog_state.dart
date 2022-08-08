import 'package:equatable/equatable.dart';
import '../data_model/drop_down_data.dart';

class AlertDialogState extends Equatable{
  final List<AlertDialogDropDownData> dropDownDataList;
  final bool isLoading, hasError;
  final String selectedId, errorMessage;

  const AlertDialogState({
    this.dropDownDataList = const [],
    required this.isLoading,
    this.selectedId = '',
    this.hasError = false,
    this.errorMessage = '',
  });

  AlertDialogState copyWith({
    List<AlertDialogDropDownData>? dropDownDataList,
    bool? isLoading,
    String? selectedId,
    bool? hasError,
    String? errorMessage,
  }){
    return AlertDialogState(
      isLoading: isLoading ?? this.isLoading,
      dropDownDataList: dropDownDataList ?? this.dropDownDataList,
      selectedId: selectedId ?? this.selectedId,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, dropDownDataList, selectedId, hasError, errorMessage];

}
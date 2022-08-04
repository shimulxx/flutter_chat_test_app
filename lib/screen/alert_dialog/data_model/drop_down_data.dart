import 'package:equatable/equatable.dart';

class AlertDialogDropDownData extends Equatable{
  final String name, id, imageUrl;
  const AlertDialogDropDownData({required this.id, required this.name, required this.imageUrl});
  factory AlertDialogDropDownData.empty(){
    return const AlertDialogDropDownData(id: '', name: '', imageUrl: '');
  }

  @override
  String toString() {
    return 'DropDownData{name: $name, id: $id, imageUrl: $imageUrl}';
  }

  @override
  List<Object?> get props => [name, id, imageUrl];
}
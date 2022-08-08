import 'package:equatable/equatable.dart';

class AlertDialogDropDownData extends Equatable{
  final String name, id, imageUrl, email;
  const AlertDialogDropDownData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.email,
  });
  factory AlertDialogDropDownData.empty(){
    return const AlertDialogDropDownData(id: '', name: '', imageUrl: '', email: '');
  }


  @override
  String toString() {
    return 'AlertDialogDropDownData{name: $name, id: $id, imageUrl: $imageUrl, email: $email}';
  }

  @override
  List<Object?> get props => [name, id, imageUrl, email];
}
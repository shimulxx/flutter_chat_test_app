import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final bool isLoggedIn, hasError;
  final String errorMessage;

  const LoginState({required this.isLoggedIn, required this.errorMessage, required this.hasError});

  LoginState copyWith({bool? isLoggedIn, bool? hasError, String? errorMessage}){
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [isLoggedIn, hasError, errorMessage];

}
import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final bool isLoggedIn, hasError, isLoading;
  final String errorMessage;

  const LoginState({
    required this.isLoggedIn,
    required this.errorMessage,
    required this.hasError,
    required this.isLoading,
  });

  LoginState copyWith({bool? isLoggedIn, bool? hasError, String? errorMessage, bool? isLoading}){
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isLoggedIn, hasError, errorMessage, isLoading];

}
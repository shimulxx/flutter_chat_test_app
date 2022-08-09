import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/api/use_cases/cases.dart';
import 'package:flutter_chat_test_app/screen/login_screen/controller/login_state.dart';
import '../../../app_variable/sign_in_condition.dart';

class LoginCubit extends Cubit<LoginState>{
  final GoogleLoginUseCase googleLoginUseCase;

  LoginCubit({required this.googleLoginUseCase})
      : super(LoginState(isLoggedIn: isSignedIn, hasError: false, errorMessage: '', isLoading: false));

  void onPressLogin() async{
    try{
      emit(state.copyWith(isLoading: true));
      final curUser = await googleLoginUseCase.getUser();
      emit(state.copyWith(
        isLoading : curUser == null ? false : true,
        isLoggedIn: curUser == null ? false : true,
        hasError: false,
      ));
    }
    catch(e){
      final errorMessage = e.toString();
      emit(state.copyWith(hasError: true, errorMessage: errorMessage));
    }
  }

}
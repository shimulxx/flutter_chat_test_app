import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/api/login/use_cases/cases.dart';
import 'package:flutter_chat_test_app/screen/login_screen/controller/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app_variable/sign_in_condition.dart';

class LoginCubit extends Cubit<LoginState>{
  final GoogleLoginUseCase googleLoginUseCase;

  LoginCubit({required this.googleLoginUseCase})
      : super(LoginState(isLoggedIn: isSignedIn, hasError: false, errorMessage: ''));

  void onPressLogin() async{
    print('on press login');
    try{
      final curUser = await googleLoginUseCase.getUser();
      print('curUser: $curUser  ${state.isLoggedIn}');
      emit(state.copyWith(isLoggedIn: curUser == null ? false : true, hasError: false));
    }
    catch(e){
      final errorMessage = e.toString();
      emit(state.copyWith(hasError: true, errorMessage: errorMessage));
    }
  }

}
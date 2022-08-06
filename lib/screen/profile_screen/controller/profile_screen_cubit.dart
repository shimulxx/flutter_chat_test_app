import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/api/login/use_cases/cases.dart';
import 'package:flutter_chat_test_app/screen/profile_screen/controller/profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState>{
  final GoogleLoginUseCase googleLoginUseCase;
  ProfileScreenCubit({required this.googleLoginUseCase}) : super(const ProfileScreenState(isLoading: true));

  void loadData() async{
    final user = await googleLoginUseCase.getUser();
    emit(state.copyWith(isLoading: false, user: user));
  }

}
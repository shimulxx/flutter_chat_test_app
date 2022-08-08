import 'package:firebase_auth/firebase_auth.dart';
import '../../../screen/alert_dialog/data_model/drop_down_data.dart';
import '../repository/repository.dart';

abstract class GoogleLoginUseCase{
  Future<User?> getUser();
}

class GoogleLoginUseCaseImp implements GoogleLoginUseCase{
  final LoginRepository loginRepository;
  const GoogleLoginUseCaseImp({required this.loginRepository});

  @override
  Future<User?> getUser() {
    return loginRepository.getUser();
  }
}

abstract class GoogleLogoutUseCase{
  Future<void> logout();
}

class GoogleLogoutUseCaseImp implements GoogleLogoutUseCase{
  final LoginRepository loginRepository;

  const GoogleLogoutUseCaseImp({required this.loginRepository});

  @override
  Future<void> logout() {
    return loginRepository.logout();
  }
}

abstract class AlertDialogUserListUseCase{
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog({required String userId});
}

class AlertDialogUserListUseCaseImp implements AlertDialogUserListUseCase{
  final LoginRepository loginRepository;

  AlertDialogUserListUseCaseImp({required this.loginRepository});

  @override
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog({required String userId}) {
    return loginRepository.getUsrListForAlertDialog(userId: userId);
  }

}
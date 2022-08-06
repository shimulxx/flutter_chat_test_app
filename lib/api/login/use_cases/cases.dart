import 'package:google_sign_in/google_sign_in.dart';
import '../repository/repository.dart';

abstract class GoogleLoginUseCase{
  Future<GoogleSignInAccount?> getUser();
}

class GoogleLoginUseCaseImp implements GoogleLoginUseCase{
  final LoginRepository loginRepository;
  const GoogleLoginUseCaseImp({required this.loginRepository});

  @override
  Future<GoogleSignInAccount?> getUser() {
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
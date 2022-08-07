import 'package:firebase_auth/firebase_auth.dart';
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
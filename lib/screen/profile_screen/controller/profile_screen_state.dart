import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreenState extends Equatable{
  final bool isLoading;
  final GoogleSignInAccount? user;

  const ProfileScreenState({ required this.isLoading, this.user });

  ProfileScreenState copyWith({bool? isLoading, GoogleSignInAccount? user}){
    return ProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, user];




}
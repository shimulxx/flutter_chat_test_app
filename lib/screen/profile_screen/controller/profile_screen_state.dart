import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreenState extends Equatable{
  final bool isLoading;
  final User? user;

  const ProfileScreenState({ required this.isLoading, this.user });

  ProfileScreenState copyWith({bool? isLoading, User? user}){
    return ProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, user];




}